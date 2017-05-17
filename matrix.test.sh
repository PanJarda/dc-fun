A="\
[1 2 3]\
[4 5 6]\
[7 8 9]"

B="\
[1 2 3]\
[4 5 6]\
[7 8 9]"

printf "$A\n$B" | tr '-' '_' | dc -e '[lilj1-0;a*+:ali1-dsi0!=L]sL[0;asilLxlj1-dsj0!=N]sM[xlMx]sN[zdsasjxzla1--0:alMx]sO?lOx[lilj1-0;b*+:bli1-dsi0!=L]sL[0;bsilLxlj1-dsj0!=N]sM[xlMx]sN[zdsbsjxzlb1--0:blMx]sO?lOx[[bad input]pq]sA0;alb!=A1sk[lilj1-la*+;a]sA[li1-0;b*lk+;b]sB[lAxlBx*li1+dsi0;a1+!=C+]sC[0lCxlj1-0;a*lk+:c]sD[1silDxlj1+dsjla1+!=E]sE[1sjlExlk1+dsk0;b1+!=F]sFlFx[lilblj*+;cn9Pli1+dsi0;b1+!=A]sA[1silAx10P]sB[lBxlj1+dsjlb>C]sC[0sjlCx]sDlDx'
