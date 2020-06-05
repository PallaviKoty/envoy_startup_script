import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["envoydb"]
mydb = myclient.drop_database('envoydb')


