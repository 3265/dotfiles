import subprocess
import json

def find_current(coll):
    for dic in coll:
        if dic['visible'] == True and dic['focused'] == True:
            return dic

def find_num(coll, num):
    if not has_num(coll, num):
        return num
    return find_num(coll, num + 1)

def has_num(coll, num):
    for dic in coll:
        if dic['num'] == num:
            return True;
    return False;

def main():
    cmd = 'i3-msg -t get_workspaces'
    res_str = subprocess.check_output(cmd, shell=True)
    ws_collection = json.loads(res_str)
    visible_ws = find_current(ws_collection)
    candidate_num = visible_ws['num'] + 1
    next_no = find_num(ws_collection, candidate_num)
    return next_no

res = main()
print(res)
