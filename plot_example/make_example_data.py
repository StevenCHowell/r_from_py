import numpy as np
import pandas as pd

x = np.linspace(0, 2*np.pi, 100)
pd.DataFrame(np.c_[x, np.sin(x)]).to_csv('sin.csv', index=False)
pd.DataFrame(np.c_[x, np.cos(x)]).to_csv('cos.csv', index=False)
pd.DataFrame(np.c_[x, np.sinc(x)]).to_csv('sinc.csv', index=False)
pd.DataFrame(np.c_[x, np.sin(x)**2]).to_csv('sin2.csv', index=False)
pd.DataFrame(np.c_[x, np.cos(x)**2]).to_csv('cos2.csv', index=False)
