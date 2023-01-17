"""
This script is used scipy package to use fft to denoise the noisy signal
"""
# 1.Generate sin wave
import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft,fftfreq
from scipy.fft import rfft,rfftfreq,irfft

sample_Rate = 44100
duration = 5

def generate_sine_wave(freq, sample_rate, duration):
    x = np.linspace(0,duration,sample_rate * duration, endpoint=False)
    frequencies = x * freq
    y = np.sin((2*np.pi)* frequencies)
    return x,y

# Generate a 2 hertz sine wave that lasts for 5 seconds
x,y = generate_sine_wave(2,sample_Rate,duration)
plt.plot(x,y)
plt.xlabel('Time(s)')
plt.ylabel('Amplitude')
plt.title('Sine wave')
plt.show()

# 2. Mix the audio signal
# Assume the signal and noise are addable
t,clear = generate_sine_wave(400,sample_Rate,duration)
_,noise = generate_sine_wave(4000,sample_Rate,duration)
noise = 0.25 * noise
mixed = clear + noise

# 3. Normalisation
normal = np.int16((mixed/mixed.max())*32767)
plt.figure()
plt.plot(normal[:1000])
plt.show()

# 4. FFT implementation, from time domain to frequency domain
N = sample_Rate * duration

yf = rfft(normal)
xf = rfftfreq(N,1/sample_Rate)

plt.figure()
plt.plot(xf,np.abs(yf))
plt.show()

# 5. signal denoise
points_per_freq = len(xf)/(sample_Rate/2)

target_idx = int(points_per_freq * 4000)

yf[target_idx-1:target_idx+2] = 0
plt.figure()
plt.plot(xf,np.abs(yf))
plt.show()

# 6.reconstruct the signal in time domain
new_sig = irfft(yf)
plt.figure()
plt.plot(new_sig[:1000])
plt.show()