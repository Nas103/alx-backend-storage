#!/usr/bin/env python3
"""
Cache class for storing and retrieving data from Redis
"""
import redis
import uuid
from typing import Union


class Cache:
    """Cache class to interact with Redis"""

    def __init__(self):
        """Initialize the Redis client and flush the database"""
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store the input data in Redis with a random key and return the key
        Args:
            data: data to be stored (str, bytes, int, float)
        Returns:
            The key under which the data is stored
        """
        key = str(uuid.uuid4())  # Generate a random key using uuid
        self._redis.set(key, data)  # Store the data in Redis with the key
        return key
