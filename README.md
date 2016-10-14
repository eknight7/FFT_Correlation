===
Code for testing the relationship between Fast Fourier Transform and Correlation
===

Run `fft_auto_correlate.m`. Image results are as follows:

Selected template:

![tigerFace.png](./tigerFace.png)

Examples of circular shifts:

![tigerFaceCircShift.png](./tigerFaceCircShift.png)

Eigenvectors of the auto-correlation matrix `S`:

![S_eigenvectors_M.png](./S_eigenvectors_M.png)

Diagnolizing the matrix `S` using eigenvectors of `S`:

![S_eigDiagonalized.png](./S_eigDiagonalized.png)

FFT of the template `x`:

![fft_x.png](./fft_x.png)

References:
1. Tasmanian Tiger image from http://www.thylacineresearchunit.org/Photos-PH-PH30-5s-30-5846c.jpg
2. Code inspired from http://16623.courses.cs.cmu.edu/slides/Lecture_14.pdf

