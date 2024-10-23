import redis
import requests
from functools import wraps
from typing import Callable

# Create a Redis client
r = redis.Redis()


def cache_with_expiration(expiration: int):
    """
    A decorator to cache the response and track the number of times
    a URL is accessed. It also sets an expiration time for the cache.
    """
    def decorator(func: Callable):
        @wraps(func)
        def wrapper(url: str) -> str:
            cache_key = f"count:{url}"
            cached_page = r.get(cache_key)

            # If cached result exists, return it
            if cached_page:
                return cached_page.decode('utf-8')

            # Otherwise, fetch the page and store it in cache
            r.incr(cache_key)  # increment the access count
            result = func(url)

            # Cache the result for the given expiration time
            r.setex(cache_key, expiration, result)
            return result

        return wrapper
    return decorator


@cache_with_expiration(10)
def get_page(url: str) -> str:
    """
    Fetch the content of the URL and cache it.
    """
    response = requests.get(url)
    return response.text


if __name__ == "__main__":
    url = ("http://slowwly.robertomurray.co.uk/delay/5000/"
           "url/https://www.example.com")
    print(get_page(url))