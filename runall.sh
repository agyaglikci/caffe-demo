#!/usr/bin/env python 

import os
import sys
import subprocess
import errno
import getpass

def mkdir_p(directory):
  try:
    os.makedirs(directory)
  except OSError as exc:  # Python >2.5
    if exc.errno == errno.EEXIST and os.path.isdir(directory):
      pass
    else:
      raise


inputs = ["dog", "jaguar", "giraffe"]
networks = ["squeezenet", "tiny_yolo", "googlenet", "tiny_yolo_voc"]

for indata in inputs:
    for network in networks:
        for iter in range(10):
            outdir = "./out/" + "/".join([str(x) for x in [network, indata, iter]])
            mkdir_p(outdir)
            cmd_arr = [
		"nvprof",
		"deep_classification.py",
			indata, 
			network
	    ]
            
            print " ".join(cmd_arr) + " --> " + outdir
            continue

            process = subprocess.Popen(cmd_arr, stdout=subprocess.PIPE)
            process.wait()
            output, error = process.communicate()

            with open(outdir + "/out", "w+") as f:
                f.write(output)

            if error:
                with open(out_dir+"/err", 'w+') as f:
                    f.write(error)
 
