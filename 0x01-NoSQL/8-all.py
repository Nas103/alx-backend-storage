#!/usr/bin/env python3
"""Module that defines the list_all function."""


def list_all(mongo_collection):
    """Lists all documents in a collection.

    Args:
        mongo_collection: The pymongo collection object.

    Returns:
        A list of all documents in the collection.
        Returns an empty list if no documents.
    """
    return list(mongo_collection.find()) or []
