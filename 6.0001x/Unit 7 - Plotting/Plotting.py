import pylab as plt

samples = []
linear = []
quadratic = []
cubic = []
exponential = []

for i in range(30):
    samples.append(i)
    linear.append(i)
    quadratic.append(i**2)
    cubic.append(i**3)
    exponential.append(2**i)

""" plt.figure('linear')
plt.plot(samples, linear)
plt.figure('quadratic')
plt.plot(samples, quadratic)
plt.figure('cubic')
plt.plot(samples, cubic)
plt.figure('exponential')
plt.plot(samples, exponential)

plt.figure('linear')
plt.xlabel('linx')
plt.figure('exponential')
plt.ylim(1,30)
plt.show() """

plt.figure('cubic v. quadratic')
plt.clf()
plt.plot(samples, quadratic, 'r--', label = 'quad')
plt.plot(samples, cubic, 'g^', label = 'triploid')
plt.legend()
plt.show()