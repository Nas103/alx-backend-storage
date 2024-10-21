#!/usr/bin/env python3


def schools_by_topic(mongo_collection, topic):
    """
    Returns the list of schools having a specific topic.
    :param mongo_collection: pymongo collection object
    :param topic: string, the topic searched
    :return: list of schools with the specified topic
    """
    return list(mongo_collection.find({"topics": {"$in": [topic]}}))
