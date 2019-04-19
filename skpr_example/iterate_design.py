import pathlib
import subprocess

rscript = pathlib.Path('/home/schowell/data/myPrograms/miniconda3/envs/py37_r/bin/Rscript')
r_code = pathlib.Path('design.r')

subprocess.run([
    rscript, r_code,
    '--n_plots', '4',
    '--plot_size', '10',
])

# for n_plots in range(4, 8):
#     for plot_size in range(8, 13, 2):
#         subprocess.run([
#             rscript, r_code,
#             '--n_plots', n_plots,
#             '--plot_size', plot_size,
#         ])