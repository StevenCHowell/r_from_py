import numpy as np
import pandas as pd

x = np.linspace(0, 2*np.pi, 100)
pd.DataFrame(np.c_[x, np.sin(x)]).to_csv('data/sin.csv', index=False)
pd.DataFrame(np.c_[x, np.cos(x)]).to_csv('data/cos.csv', index=False)
pd.DataFrame(np.c_[x, np.sinc(x)]).to_csv('data/sinc.csv', index=False)
pd.DataFrame(np.c_[x, np.sin(x)**2]).to_csv('data/sin2.csv', index=False)
pd.DataFrame(np.c_[x, np.cos(x)**2]).to_csv('data/cos2.csv', index=False)
