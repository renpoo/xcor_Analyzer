function E = estimateErrorAmount_for_phi_lr_(n, phi_lr)

u = 2^-53

GAMMA = n*u/(1-n*u)

E = sum(phi_lr) * GAMMA

