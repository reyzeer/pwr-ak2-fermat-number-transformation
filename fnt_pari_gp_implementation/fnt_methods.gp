fermat_number(base) = {
	fnum = 2^2^base + 1;
	return(fnum);
}

fnt(datain, fermat_number_base, alpha) = {
	fermat_number = 2^2^fermat_number_base + 1;
	N = length(datain);
	dataout = vector(N);
	for (count_element = 1, N,

        	summ = 0;
        	for (k=1, N,

                	x_k = datain[k];
                	kernel = alpha^(count_element*k);
                	summ += x_k * kernel;

        	);  

        	result = summ % fermat_number;
        	dataout[count_element] = result;
);
	return(dataout);
}

fnt_revers(datain, fermat_number_base, alpha) = {
        fermat_number = 2^2^fermat_number_base + 1;
        N = length(datain);
        dataout = vector(N);
        for (count_element = 1, N,

                summ = 0;
                for (k=1, N,

                        x_k = datain[k];
                        kernel = alpha^(-count_element*k);
                        summ += x_k * kernel;

                );

                result = 1/N *summ % fermat_number;
                dataout[count_element] = result;
);
        return(dataout);
}

discrete_convolution(sequence1, sequence2) = {

	N = length(sequence1);
	dataout = vector(N);
	
	for (n = 1, N,

		summ = 0;
		for (m = 1, N,
		
			index = n - m;
			if (index < 1, index = 1;);
			summ = sequence1[index] * sequence2[m];
		);
	
		dataout[n] = summ;

	);
	
	return(dataout);
}

\\ Dane wejsciowe
datain1 = [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
datain2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];

alpha = 2;
fermat_number_base = 4;

N = length(datain);
fermat_number = fermat_number(fermat_number_base);

print("Alpha condition: alpha^N % fermat_numer == 1: ", (alpha^N) % fermat_number);
print("Fermat_number condition: fermat_number > max(datain): ", fermat_number, " > ", vecmax(datain));

out1 = fnt(datain1,fermat_number_base, alpha);
out2 = fnt(datain2, fermat_number_base, alpha);

out = fnt_revers(out1, fermat_number_base, alpha);

print("datain1:");
for (i=1, N, print(i, ":\t", datain1[i], "\t->\t", out1[i], "\t"));

print("datain2:");
for (i=1, N, print(i, ":\t", datain2[i], "\t->\t", out2[i], "\t"));

conv = vector(N);
for (i=1, N, conv[i] = out1[i] * out2[i];);
\\for (i=1, N, conv[i] = out1[i] - out2[i];);
\\for (i=1, N, conv[i] = out1[i] + out2[i];);
\\for (i=1, N, conv[i] = out1[i] * 3);
\\for(i=1, N, conv[i] = out1[i] / 10); \\ Dziala dla wszystkich z wyjatkiem 3
out = discrete_convolution(out1, out2); 
out = fnt_revers(conv, fermat_number_base, alpha);

for (i=1, N, print(i, ":\t", conv[i], "\t->\t", out[i], "\t"));

x = vector(N);
for(i=1, N, x[i] = i);

plothraw(x, out, 1);
quit();

