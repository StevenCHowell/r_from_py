import pathlib
import subprocess

rscript = pathlib.Path('/home/schowell/data/myPrograms/miniconda3/envs/py37_r/bin/Rscript')
r_code = pathlib.Path('plot_data.r')
path_data = pathlib.Path('data/')
assert path_data.exists(), f'no such path: {path_data}'
for fname in path_data.glob('*.csv'):
    subprocess.run([rscript, r_code, fname])
