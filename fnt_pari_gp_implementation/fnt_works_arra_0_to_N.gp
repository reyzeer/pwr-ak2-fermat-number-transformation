fermat_number(base) = {
	fnum = 2^2^base + 1;
	return(fnum);
}

\\ Dane wejsciowe
datain = [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
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
for (count_element = 0, N-1,

	summ = 0.0;
	for (k=0, N-1,

		x_k = datain[k+1];
		kernel = alpha^(count_element*k);
		summ += x_k * kernel;

		\\ print("x_k: ", x_k, " kernel: ", kernel, " summ: ", summ);		

	);

	\\ quit();

	result = summ % fermat_number;
	dataout[count_element+1] = result;
	\\ print(count_element, ": ", result);
);
}

{
for (count_element = 0, N-1,

        summ = 0.0;
        for (k=0, N-1,

                x_k = dataout[k+1];
                kernel = alpha^(-count_element*k);
                summ += x_k * kernel;

                \\ print("x_k: ", x_k, " kernel: ", kernel, " summ: ", summ);            

        );  

        result = 1/N * summ % fermat_number;
        redatain[count_element+1] = result;
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

