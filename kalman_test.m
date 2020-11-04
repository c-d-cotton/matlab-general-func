clear

y = [0, 2, -2, 0, 1, -1, 0, 0, 0]
F = [0.5, 0.1; 0.3, 0.1]
H = [1; 1]
Q = [1]
S = [1; 0]
R = [1]

[xif, Pf, xic, Pc] = kalman(y, F, H, Q, S, R)

