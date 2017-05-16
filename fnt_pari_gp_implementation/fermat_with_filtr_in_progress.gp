fermat_number(base) = {
	fnum = 2^2^base + 1;
	return(fnum);
}

fnt(datain, fermat_number_base, alpha) = {
	fermat_number = 2^2^fermat_number_base; \\fermat_number(fermat_number_base);
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
        fermat_number = fermat_number(fermat_number_base);
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

for (i=1, N, out1[i] = out1[i] * out2[i];);
for (i=1, N, print(i, ":\t", out1[i], "\t->\t", out2[i], "\t->\t"));\\, redatain[i]));

quit();

\\ datain = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];
alpha = 2;
fermat_number_base = 4;

N = length(datain);
fermat_number = fermat_number(fermat_number_base);

print("Alpha condition: alpha^N % fermat_numer == 1: ", (alpha^N) % fermat_number);
print("Fermat_number condition: fermat_number > max(datain): ", fermat_number, " > ", vecmax(datain));

\\ Najwieksza wartosc wektora danych
q = fermat_number - 1;
 
print("GCD [alpha^N - 1, q] = 1: ", gcd((alpha^N)-1, q)); 

print("N: ", N);
print("Fermat number: ", fermat_number);

dataout = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
redatain = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

{
for (count_element = 1, N,

	summ = 0;
	for (k=1, N,

		x_k = datain[k];
		kernel = alpha^(count_element*k);
		summ += x_k * kernel;

		\\print("x_k: ", x_k, " kernel: ", kernel, " summ: ", summ);		

	);

	result = summ % fermat_number;
	dataout[count_element] = result;
	\\ print(count_element, ": ", result);
);
}

{
for (i=1, N,
	dataout[i] = dataout[i] * 2;
	\\if (dataout[i] > 66000, dataout[i] = dataout[i]-1);
);
}

{
for (count_element = 1, N,

        summ = 0;
        for (k=1, N,

                x_k = dataout[k];
                kernel = alpha^(-count_element*k);
                summ += x_k * kernel;

                \\print("x_k: ", x_k, " kernel: ", kernel, " summ: ", summ);            

        );  

        result = 1/N * summ % fermat_number;
        redatain[count_element] = result;
        \\ print(count_element, ": ", result);
);
}

{
for (i=1, N, print(i, ":\t", datain[i], "\t->\t", dataout[i], "\t->\t", redatain[i]));
}

x=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];



plothraw(x, dataout, 1);
quit();

\\plotinit(0, 1000, 1000);
s = plothsizes();

plotinit(0, 1200, 800);
plotscale(0, 1, 10, 1, 10);
plotlines(0, x, dataout);
plotdraw([0, 0, 0]);

quit();

