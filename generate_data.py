import numpy as np
from scipy.constants import c
from scipy import signal


rf_fc = 10e9  # Hz

bw = 1e6  # Hz
if_offset = 1e6  # Hz
if_fc = bw / 2 + if_offset  # Hz

prf = 1.25e3  # Hz

pri = 1 / prf  # s
tau = pri / 20

snr = 10  # dB

M = 1024
N = 50000000
target_idx = 32500000

# Generate filter
t_filter = np.linspace(0, tau, M)
pulse = signal.chirp(t_filter, if_fc - bw / 2, tau, if_fc + bw / 2).astype(np.float32)

# generate signal
signal_array = np.random.normal(0, 0.5, N).astype(np.float32)

signal_array[target_idx : target_idx + M] += pulse

pulse.tofile("filter.bin")
signal_array.tofile("signal.bin")

