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

                result = 1/N *summ % fermat_number;
                dataout[count_element+1] = result;
);
        return(dataout);
}

fnt2d(datain, width, height, fermat_number_base, alpha) = {
	fermat_number = 2^2^fermat_number_base + 1;
	dataout = matrix(height, width);
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

width=4;
height=4;

datain = [10, 10, 10, 10; 10, 10, 10, 0; 10, 10, 0, 0; 10, 0, 0, 0; 0, 0, 0, 0];
datainfnt = fnt2d(datain, width, height, 4, 2);

{
    for (i=1, width,
            for (j=1, height,
                print("[", i, ",", j, "]", ":\t", datain[i,j], "\t->\t"); \\, datainfnt[i,j], "\t")
        );
    );
}

quit;

\\ Dane wejsciowe
datain1 = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
datain2 = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
\\ datain2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];

alpha = 2;
fermat_number_base = 4;

N = length(datain);
fermat_number = fermat_number(fermat_number_base);

print("Alpha condition: alpha^N % fermat_numer == 1: ", (alpha^N) % fermat_number);
print("Fermat_number condition: fermat_number > max(datain): ", fermat_number, " > ", vecmax(datain));

out1 = fnt(datain1,fermat_number_base, alpha);
out2 = fnt(datain2, fermat_number_base, alpha);

out = fnt_revers(out1, fermat_number_base, alpha);

print_vector_source_result("datain1 to fnt", datain1, out1);
print_vector_source_result("datain2 to fnt", datain2, out2);

print_vector_source_result("out1 - revers", out1, fnt_revers(out1, fermat_number_base, alpha));
print_vector_source_result("out2 - revers", out2, fnt_revers(out2, fermat_number_base, alpha));
print_vector_source_result("out1 - out2", out1 - out2, fnt_revers(out1 - out2, fermat_number_base, alpha));
print_vector_source_result("out1 + out2", out1 + out2, fnt_revers(out1 + out2, fermat_number_base, alpha));
print_vector_source_result("out1 * out2", multi_by_positions(out1, out2), fnt_revers(multi_by_positions(out1, out2), fermat_number_base, alpha));
print_vector_source_result("out1 / out2", divide_by_positions(out1, out2), fnt_revers(divide_by_positions(out1, out2), fermat_number_base, alpha));
print_vector_source_result("out1 * 3", out1 * 3, fnt_revers(out1 * 3, fermat_number_base, alpha));
print_vector_source_result("out1 / 10", out1 / 10, fnt_revers(out1 / 10, fermat_number_base, alpha));
print_vector_source_result("Conv result to fnt^(-1)", discrete_convolution(out1, out2), fnt_revers(discrete_convolution(out1, out2), fermat_number_base, alpha));

x = vector(N);
for(i=1, N, x[i] = i);

\\plothraw(x, out, 1);
quit();

