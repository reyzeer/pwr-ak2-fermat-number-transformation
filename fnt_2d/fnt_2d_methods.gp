fermat_number(base) = {
	fnum = 2^2^base + 1;
	return(fnum);
}

fnt(datain, fermat_number_base, alpha) = {
	fermat_number = 2^2^fermat_number_base + 1;
	N = length(datain);
	dataout = vector(N);
	for (count_element = 0, N-1,

        	summ = 0;
        	for (k=0, N-1,

                	x_k = datain[k+1];
                	kernel = alpha^(count_element*k);
                	summ += x_k * kernel;

        	);  

        	result = summ % fermat_number;
        	dataout[count_element+1] = result;
);
	return(dataout);
}

fnt_revers(datain, fermat_number_base, alpha) = {
        fermat_number = 2^2^fermat_number_base + 1;
        N = length(datain);
        dataout = vector(N);
        for (count_element = 0, N-1,

                summ = 0;
                for (k=0, N-1,

                        x_k = datain[k+1];
                        kernel = alpha^(-count_element*k);
                        summ += x_k * kernel;

                );

                result = 1/N * summ % fermat_number;
                dataout[count_element+1] = result;
	);
        return(dataout);
}

fnt2d_element(datain, width, height, i, j, alpha, fermat_number) = {
	summ = 0;
	for (k=0, height-1,
		for (l=0, width-1,
			x_kl = datain[k+1,l+1];
			kernel = alpha^(i*k+j*l);
			summ += x_kl * kernel;
		);
	);
	\\ print(i, ".\t", j, ".\t", summ);
	result = summ % fermat_number;
	return(result);
}

fnt2d(datain, width, height, fermat_number_base, alpha) = {
	fermat_number = 2^2^fermat_number_base + 1;
	dataout = matrix(height, width);
	for (i=0, height-1,
		for(j=0, width-1, 
			dataout[i+1, j+1] = fnt2d_element(datain, width, height, i, j, alpha, fermat_number);
		);
	);
	return(dataout);
}

fnt2d_revers_element(datain, width, height, i, j, alpha, fermat_number) = { 
        summ = 0;
        for (k=0, height-1,
                for (l=0, width-1,
                        x_kl = datain[k+1,l+1];
                        kernel = alpha^(-i*k-j*l);
                        summ += x_kl * kernel;
                );  
        );  
	\\ print(i, ".\t", j, ".\t", summ);
        result = 1/(width*height) * summ % fermat_number;
        return(result);
}

fnt2d_revers(datain, width, height, fermat_number_base, alpha) = { 
        fermat_number = 2^2^fermat_number_base + 1;
        dataout = matrix(height, width);
        for (i=0, height-1,
                for(j=0, width-1, 
                        dataout[i+1, j+1] = fnt2d_revers_element(datain, width, height, i, j, alpha, fermat_number);
                );  
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

print_vector_source_result(title, a, b) = {
	print(title, ":");
	N = length(a);
	for (i=1, N,
		print(i, ":\t", a[i], "\t->\t", b[i], "\t")
	);
}

multi_by_positions(a, b) = {
	result = vector(N);
	for (i=1, N, result[i] = out1[i] * out2[i];);
	return(result);
}


divide_by_positions(a, b) = { 
        result = vector(N);
        for (i=1, N, result[i] = out1[i] / out2[i];);
        return(result);
}

alpha=2;
fermat_number_base=4;
width=32;
height=32;

N = width*height;
fermat_number = fermat_number(fermat_number_base);

print("Alpha condition: alpha^N % fermat_numer == 1: ", (alpha^N) % fermat_number);
print("Fermat_number condition: fermat_number > max(datain): ", fermat_number, " > ", vecmax(datain));

\\ Najwieksza wartosc wektora danych
q = fermat_number - 1;
 
print("GCD [alpha^N - 1, q] = 1: ", gcd((alpha^N)-1, q)); 

print("N: ", N);
print("Fermat number: ", fermat_number);

datain = read("imgin_vector.txt");

datainfnt = fnt2d(datain, width, height, fermat_number_base, alpha);

mask = matrix(32,32);
for(i=1,32, for(j=1,32, mask[i,j] = 1));

datainfnt = datainfnt + 100*mask;
\\ datainfnt = datainfnt / 10;

mask = matrix(32,32);
for(i=1,16, for(j=1,32, mask[i,j] = 1));

\\ datainfnt = datainfnt * mask;

dataout = fnt2d_revers(datainfnt, width, height, fermat_number_base, alpha);

{
    for (i=1, width,
            for (j=1, height,
                print("[", i, ",", j, "] ", ":\t", datain[i,j], "\t->\t", datainfnt[i,j], "\t->\t", dataout[i,j]);
        );
    );
}

write("imginfnt_vector.txt", datainfnt);
write("imgout_vector.txt", dataout);

quit;
