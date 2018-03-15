import os

import sys


def current_file_dir():
    path = sys.path[0]

    if os.path.isdir(path):
        return path
    elif os.path.isfile(path):
        return os.path.dirname(path)






def printToFile(strings, outPutPath):
    fCnOut = open(outPutPath, 'w');

    print >> fCnOut

    strings.sort();
    for str in strings:
        print >> fCnOut, str + '\n'

    fCnOut.close();





def scan_dir(start_dir):
    os.chdir(start_dir)
    result = []
    for obj in os.listdir(os.curdir):
        if obj.endswith('ViewController.h') and obj.startswith('SJ'):
            define_str = obj.replace('SJ', '').replace('TableViewController.h', '').replace('ViewController.h', '')
            if define_str != '':
                value_str = '@"SJFuPin://' + obj.replace('Controller.h', 'ModelProtocol"')
                result_str = '#define Router_' + define_str + '\t' + value_str
                result.append(result_str)
    
    
        if os.path.isdir(obj):
            re = scan_dir(obj)
            if len(re) > 0:
                for r in re:
                    result.append(r)
        
        
            os.chdir(os.pardir)  # !!!
        
    return result


pass


def main(argv):
    current_dir = current_file_dir()
    start_dir = current_dir + '/../../Classes'
    print start_dir
    
    result = scan_dir(start_dir)

    printToFile(result, current_dir + "/SJRouterDefine.h")
pass

if __name__ == '__main__':
    main(sys.argv)
