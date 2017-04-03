close all
clear all

syms P L lt ua ub uc ud ue;
var = [P;L;lt];
z(P, L, lt) = 0.1*P + 0.1*L + 210*lt; zz = 0.1*P + 0.1*L + 210*lt;
obj = 0.1*P + 0.1*L + 210*lt;
a(P, L, lt) = P*L*lt - 20000; aa = P*L*lt - 20000;
b(P) = P-100;   bb = P-100;
c(L) = L-100;   cc = L-100;
d(lt) = 3.5*lt-21; dd = 3.5*lt-21;
e(P, L, lt) = P*L+P*L*lt/4 - 10000; ee =P*L+P*L*lt/4 - 10000;

zlamda(P,L,lt) = 0.1*P + 0.1*L + 210*lt - ua*(P*L*lt - 20000) - ub*(P-100) - uc*(L-100) - ud*(3.5*lt-21) - ue*(P*L+P*L*lt/4 - 10000);

zzlam = zz-ua*aa -ub*bb - uc*cc -ud*dd -ue*ee


zP = diff(zlamda,P);
zL = diff(zlamda,L);
zlt= diff(zlamda,lt);
