import json
with open("/Users/aymericballester/Documents/dev/python/Contacts/qml/models/contacts_seb.json", 'r') as seb_json:
    seb_datas = json.load(seb_json)

with open("/Users/aymericballester/Documents/dev/python/Contacts/qml/models/contacts_test.json", 'r') as aym_json:
    aym_datas = json.load(aym_json)

# count = 0
# json_lst = []

# for index, aym_data in enumerate(aym_datas):
#     new_index = (index % 499)+1
#     seb_address = (seb_datas[new_index]["location"])

#     if count % 2 == 0:
#         new_address = f"{seb_address}, Canada"

#         if new_index == 499:
#             count += 1
#     else:
#         aym_address = aym_data["contact_infos"][2]["data"]["address"]
#         seb_address_list = seb_address.split(", ")

#         new_address = f"{aym_address}{', '.join(seb_address_list[1:])}, Canada"

#     aym_data["contact_infos"][2]["data"] = {"address": new_address}

#     json_lst.append(aym_data)

for index, seb_data in enumerate(seb_datas):
    aym_datas[index]["picture"] = seb_data["picture"]

json_lst = aym_datas

with open('/Users/aymericballester/Documents/dev/python/Contacts/qml/models/contacts_test2.json', 'w') as outfile:
    json.dump(json_lst, outfile, indent=4)
