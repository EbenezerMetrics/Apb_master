#!/usr/bin/python3
import json
import argparse

# Command line arguments
parser = argparse.ArgumentParser(description='Script to convert regression test list into Metrics json format')
parser.add_argument('testFile', help='Test list filename')
args = parser.parse_args()

runCmdBase = "cd /mux-flow/results; <rootDir>/dsim_sim "
runCmdWavesBase = "cd /mux-flow/results; <rootDir>/dsim_sim "

testList = []

with open(args.testFile, 'r') as testFile:
    for line in testFile:
        test = {}
        line = line.rstrip()
        if len(line) > 0:
            (testName, iterations) = line.split(':')
            test["name"] = testName
            test["iterations"] = int(iterations)
            test["logFile"] = "dsim_sim_log"    
            test["build"] = "apb_master"
            test["cmd"] = runCmdBase + test["name"]
            test["wavesCmd"] = runCmdWavesBase + test["name"]
            test["wavesFile"] = "waves.vcd.gz"
            test["metricsFile"] = "metrics.db"
                        
            testList.append(test)

jsonTestFile = args.testFile.replace(".txt", ".json", 1)
with open(jsonTestFile, "w") as f:
    json.dump(testList, f)
