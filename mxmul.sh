#!/bin/sh
#
# mxmul.sh - POSIX compliant matrix multiplication
#
# Usage:
# A="[1 2 3]\
#    [3 4 5]\
#    [6 7 8]"
# B="[1 2 3]\
#    [3 4 5]\
#    [6 7 8]"
# $ ./mxmul.sh "$A" "$B"

replace_minus_sign () {
	echo $1 | tr '-' '_'
}

get_nth_vector_element () {
	vector=`replace_minus_sign "$1"`
	n="$2"
	echo "$vector\n$n" | dc -e '? z ? - sn [pq]sQ [ln 0=Q s. ln 1- sn lMx]dsMx'
}

get_nth_matrix_row () {
	matrix=`replace_minus_sign "$1"`
	n="$2"
	get_nth_vector_element "$matrix" $n
}

get_nth_matrix_col () {
	matrix=`replace_minus_sign "$1"`
	n="$2"
	result=''
	row_count=`count_rows "$matrix"`
	
	for i in `seq 1 $row_count`
	do
		row=`get_nth_matrix_row "$matrix" $i`
		element=`get_nth_vector_element "$row" $n`
		result=`echo $result $element`
	done
}

count_rows () {
	matrix=`replace_minus_sign "$1"`
	echo $matrix | dc -e '? z p'
}

count_cols () {
	matrix=`replace_minus_sign "$1"`
	echo $matrix | dc -e '? sa c la x z p'
}

check_valid_matrix () {
	matrix=`replace_minus_sign "$1"`
	rows=`count_rows "$matrix"`
	last_row_cols=`count_cols "$matrix"`
	
	for i in `seq 1 $rows`
	do
		row_cols=`get_nth_matrix_row "$matrix" $i | dc -e '? z p'`
		
		if [ $last_row_cols -ne $row_cols ]
		then
			return 1
		fi
	done
	return 0
}

check_valid_matrix_multiplication () {
	matrix_A=`replace_minus_sign "$1"`
	matrix_B=`replace_minus_sign "$2"`
	A_cols=`count_cols "$matrix_A"`
	B_rows=`count_rows "$matrix_B"`

	if [ $A_cols -ne $B_rows ]
	then
		return 1
	else
		return 0
	fi
}

compute_vector_scalar_product () {
	vector_a=`replace_minus_sign "$1"`
	vector_b=`replace_minus_sign "$1"`
	echo "$vector_a\n$vector_b" | dc -e '? z d sn si [Sa li1-dsi0!=A]dsAx ? ln si [Sb li1-dsi0!=B]dsBx ln si 0 [La Lb * + li1-dsi0!=C]dsCx p'
}

multiply_matrices () {
	matrix_A=`replace_minus_sign "$1"`
	matrix_B=`replace_minus_sign "$1"`
	matrix_A_row_count=`count_rows "$matrix_A"`
	matrix_B_col_count=`count_cols "$matrix_B"`
	
	for row_num in `seq 1 $matrix_A_row_count`
	do
		matrix_A_row=`get_nth_matrix_row "$matrix_A" $row_num`
		printf '['
		for col_num in `seq 1 $matrix_B_col_count`
		do
			matrix_B_col=`get_nth_matrix_col "$matrix_B" $col_num`
			echo -n `compute_vector_scalar_product "$matrix_A_row" "$matrix_B_col"` "\t"
		done
		echo ']'
	done
}

matrix_A=`replace_minus_sign "$1"`
matrix_B=`replace_minus_sign "$2"`

check_valid_matrix "$matrix_A"

if [ $? -ne 0 ]
then
	echo 'Invalid matrix A!' 1>&2
	exit 1
fi

check_valid_matrix "$matrix_B"

if [ $? -ne 0 ]
then
	echo 'Invalid matrix B!' 1>&2
	exit 1
fi

check_valid_matrix_multiplication "$matrix_A" "$matrix_B"

if [ $? -ne 0 ]
then
	echo 'Invalid multiplication!' 1>&2
	exit 1
fi

multiply_matrices "$matrix_A" "$matrix_B"
