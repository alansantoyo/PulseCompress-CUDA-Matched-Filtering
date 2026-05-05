import matplotlib.pyplot as plt
import numpy as np

output_data = np.fromfile('MatchedFiltering/src/output.bin', dtype=np.float32)
signal_data = np.fromfile('MatchedFiltering/src/signal.bin', dtype=np.float32)
filter_data = np.fromfile('MatchedFiltering/src/filter.bin', dtype=np.float32)

files = {
    "Baseline Kernel":  'MatchedFiltering/src/output.bin',
    "Tiled Kernel":     'MatchedFilteringTiled/src/output.bin',
    "Coarsened Kernel": 'MatchedFilteringTiledCoarsened/src/output.bin'
}

for name, path in files.items():

    output_data = np.fromfile(path, dtype=np.float32)
    
    target_idx = np.argmax(output_data)
    window_size = 5000
    start_idx = max(0, target_idx - window_size)
    end_idx = min(len(output_data), target_idx + window_size)
    
    signal_slice = signal_data[start_idx:end_idx]
    output_slice = output_data[start_idx:end_idx]
    x_axis = np.arange(start_idx, end_idx)

    fig, axs = plt.subplots(3, 1, figsize=(10, 8), num=f"Radar Results: {name}")

    axs[0].plot(filter_data, color='#1f77b4') 
    axs[0].set_title('1. Radar Pulse (The Matched Filter)')
    axs[0].set_ylabel('Amplitude')
    axs[0].grid(True, alpha=0.3)

    axs[1].plot(x_axis, signal_slice, color='gray')
    axs[1].set_title(f'2. Raw Signal + Noise (Windowed at Index {target_idx})')
    axs[1].set_ylabel('Amplitude')
    axs[1].grid(True, alpha=0.3)

    axs[2].plot(x_axis, output_slice, color='#d62728')
    axs[2].set_title('3. Filter Output (Target Isolated)')
    axs[2].set_xlabel('Sample Index')
    axs[2].set_ylabel('Relative Power')
    axs[2].grid(True, alpha=0.3)

    axs[2].axvline(x=target_idx, color='black', linestyle='--', alpha=0.6, label='Detected Peak')
    axs[2].legend()

    plt.tight_layout()

plt.show()