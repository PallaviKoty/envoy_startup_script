import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["envoydb"]
mycol = mydb["amr_payload_status"]

x = mycol.delete_many({})

print(x.deleted_count, " documents deleted.")

mydict = {"amr_id": 3, "name": "AMR01"}

x = mycol.insert_one(mydict)
