#!/usr/bin/env python3
"""Module to find schools by a specific topic."""


def schools_by_topic(mongo_collection, topic):
    """Returns the list of schools having a specific topic.

    Args:
        mongo_collection: The pymongo collection object.
        topic (str): The topic to search for.

    Returns:
        List of schools matching the topic.
    """
    return mongo_collection.find({"topics": topic})
