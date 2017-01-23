function qsw = microstrip_qsw(qsp, lambda, k_0, h, c1, e_r)
psp = (1./(lambda.^2)).*((k_0.*h).^2).*(80.*pi.*pi.*c1)
psw = (1./(lambda.^2)).*((k_0.*h).^3).*(60.*pi.*pi.*pi.*((1-1./(e_r)).^2))
e = (psp./(psp+psw))
qsw = qsp.*(e./(1-e))
endfunction
