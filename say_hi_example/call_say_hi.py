import subprocess

output = subprocess.run(['/home/schowell/data/myPrograms/anaconda3/envs/py37_r/bin/Rscript', 'say_hi.r'])

print(f'returncode: {output.returncode}')
