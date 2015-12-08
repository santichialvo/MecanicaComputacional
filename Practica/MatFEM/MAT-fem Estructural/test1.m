%=======================================================================
% MAT-fem 1.0  - MAT-fem is a learning tool for undestanding 
%                the Finite Element Method with MATLAB and GiD
%=======================================================================
% PROBLEM TITLE = Titulo del problema
%
%  Material Properties
%
  young =   210000000000.00000 ;
  poiss =              0.20000 ;
  denss =          78000.00000 ;
  pstrs =  1 ;
  thick =  1 ;
%
% Coordinates
%
global coordinates
coordinates = [
            0 ,           1 ;
	      0.1 ,           1 ;
	      0 ,         0.9 ;
	      0.088132 ,     0.86335 ;
	      0.16323 ,     0.91677 ;
	      0.2 ,           1 ;
	      0 ,         0.8 ;
	      0.25 ,      0.9134 ;
	      0.18342 ,     0.80249 ;
	      0.086024 ,     0.74284 ;
	      0.3 ,           1 ;
	      0 ,         0.7 ;
	      0.15 ,      0.6866 ;
	      0.29659 ,     0.80788 ;
	      0.35 ,      0.9134 ;
	      0.4 ,           1 ;
	      0 ,         0.6 ;
	      0.25 ,      0.6866 ;
	      0.1 ,         0.6 ;
	      0.39943 ,      0.8028 ;
	      0.2 ,         0.6 ;
	      0.45 ,      0.9134 ;
	      0.35 ,      0.6866 ;
	      0.5 ,           1 ;
	      0.3 ,         0.6 ;
	      0.5 ,     0.80893 ;
	      0.44991 ,     0.69749 ;
	      0.55 ,      0.9134 ;
	      0.4 ,         0.6 ;
	      0.6 ,           1 ;
	      0 ,         0.4 ;
	      0.1 ,         0.4 ;
	      0.6 ,     0.82679 ;
	      0.2 ,         0.4 ;
	      0.5 ,         0.6 ;
	      0.56814 ,     0.68665 ;
	      0.65 ,      0.9134 ;
	      0.3 ,         0.4 ;
	      0 ,         0.3 ;
	      0.7 ,           1 ;
	      0.15 ,      0.3134 ;
	      0.5 ,         0.5 ;
	      0.7 ,     0.82679 ;
	      0.4 ,         0.4 ;
	      0.66726 ,     0.72337 ;
	      0.25 ,      0.3134 ;
	      0.5866 ,        0.55 ;
	      0.086024 ,     0.25716 ;
	      0.75 ,      0.9134 ;
	      0.5 ,         0.4 ;
	      0.74019 ,        0.75 ;
	      0.67321 ,         0.6 ;
	      0.35332 ,     0.29863 ;
	      0.8 ,           1 ;
	      0 ,         0.2 ;
	      0.5866 ,        0.45 ;
	      0.74019 ,        0.65 ;
	      0.1835 ,     0.19786 ;
	      0.67321 ,         0.5 ;
	      0.82046 ,     0.82046 ;
	      0.46951 ,     0.29566 ;
	      0.29713 ,     0.19461 ;
	      0.088792 ,     0.13971 ;
	      0.74019 ,        0.55 ;
	      0.86454 ,     0.91177 ;
	      0.5866 ,        0.35 ;
	      0.82679 ,         0.7 ;
	      0.9 ,           1 ;
	      0 ,         0.1 ;
	      0.67321 ,         0.4 ;
	      0.40325 ,     0.18811 ;
	      0.82679 ,         0.6 ;
	      0.74019 ,        0.45 ;
	      0.55 ,     0.25981 ;
	      0.91677 ,     0.83677 ;
	      0.16323 ,    0.083228 ;
	      0.24898 ,    0.093717 ;
	      0.9134 ,        0.75 ;
	      0.82679 ,         0.5 ;
	      0.5 ,     0.17321 ;
	      0.67321 ,         0.3 ;
	      0.9134 ,        0.65 ;
	      0.35 ,    0.086603 ;
	      0.74019 ,        0.35 ;
	      0 ,           0 ;
	      1 ,           1 ;
	      0.1 ,           0 ;
	      1 ,         0.9 ;
	      0.9134 ,        0.55 ;
	      0.45 ,    0.086603 ;
	      0.2 ,           0 ;
	      1 ,         0.8 ;
	      0.82679 ,         0.4 ;
	      0.6 ,     0.17321 ;
	      1 ,         0.7 ;
	      0.3 ,           0 ;
	      0.7585 ,      0.2556 ;
	      0.9134 ,        0.45 ;
	      0.55 ,    0.086603 ;
	      1 ,         0.6 ;
	      0.4 ,           0 ;
	      0.82679 ,         0.3 ;
	      0.7 ,     0.17321 ;
	      1 ,         0.5 ;
	      0.5 ,           0 ;
	      0.9134 ,        0.35 ;
	      0.65 ,    0.086603 ;
	      0.82046 ,     0.17954 ;
	      1 ,         0.4 ;
	      0.6 ,           0 ;
	      0.9134 ,        0.25 ;
	      0.75 ,    0.086603 ;
	      1 ,         0.3 ;
	      0.7 ,           0 ;
	      0.91677 ,     0.16323 ;
	      0.86454 ,    0.088228 ;
	      1 ,         0.2 ;
	      0.8 ,           0 ;
	      1 ,         0.1 ;
	      0.9 ,           0 ;
	      1 ,           0  ];
%
% Elements
%
global elements
elements = [
    31,  39,  32;
    39,  55,  48;
    55,  69,  63;
    69,  85,  87;
    87,  91,  76;
    91,  96,  77;
    96, 101,  83;
   101, 105,  90;
   105, 110,  99;
   110, 114, 107;
   114, 118, 112;
   118, 120, 116;
   120, 121, 119;
   119, 117, 115;
   117, 113, 111;
   113, 109, 106;
   109, 104,  98;
   104, 100,  89;
   100,  95,  82;
    95,  92,  78;
    92,  88,  75;
    88,  86,  68;
    68,  54,  65;
    54,  40,  49;
    40,  30,  37;
    30,  24,  28;
    24,  16,  22;
    16,  11,  15;
    11,   6,   8;
     6,   2,   5;
     2,   1,   3;
     3,   7,   4;
     7,  12,  10;
    12,  17,  19;
    19,  21,  13;
    21,  25,  18;
    25,  29,  23;
    29,  35,  27;
    35,  42,  47;
    42,  50,  56;
    50,  44,  61;
    44,  38,  53;
    38,  34,  46;
    34,  32,  41;
    48,  55,  63;
    39,  48,  32;
    63,  69,  87;
    76,  91,  77;
    87,  76,  63;
    63,  76,  58;
    58,  76,  77;
    63,  58,  48;
    77,  96,  83;
    83, 101,  90;
    90, 105,  99;
    99, 110, 107;
   107, 114, 112;
   112, 118, 116;
   116, 120, 119;
   115, 117, 111;
   119, 115, 116;
   116, 115, 108;
   108, 115, 111;
   116, 108, 112;
   111, 113, 106;
   106, 109,  98;
    98, 104,  89;
    89, 100,  82;
    82,  95,  78;
    78,  92,  75;
    75,  88,  65;
    65,  54,  49;
    68,  65,  88;
    75,  65,  60;
    60,  65,  49;
    75,  60,  78;
    49,  40,  37;
    37,  30,  28;
    28,  24,  22;
    22,  16,  15;
    15,  11,   8;
     8,   6,   5;
     5,   2,   4;
     4,   7,  10;
     3,   4,   2;
     5,   4,   9;
     9,   4,  10;
     5,   9,   8;
    10,  12,  19;
    13,  21,  18;
    19,  13,  10;
    10,  13,   9;
    18,  25,  23;
    23,  29,  27;
    27,  35,  36;
    47,  42,  56;
    35,  47,  36;
    56,  50,  66;
    61,  44,  53;
    50,  61,  66;
    53,  38,  46;
    46,  34,  41;
    41,  32,  48;
    41,  48,  58;
    77,  83,  62;
    83,  90,  71;
    90,  99,  80;
    99, 107,  94;
   107, 112, 103;
   111, 106, 102;
   106,  98,  93;
    98,  89,  79;
    89,  82,  72;
    82,  78,  67;
    49,  37,  43;
    37,  28,  33;
    28,  22,  26;
    22,  15,  20;
    15,   8,  14;
    13,  18,   9;
    18,  23,  14;
    23,  27,  20;
    27,  36,  26;
    47,  56,  59;
    56,  66,  70;
    61,  53,  71;
    53,  46,  62;
    46,  41,  58;
    62,  83,  71;
    77,  62,  58;
    71,  90,  80;
    80,  99,  94;
    94, 107, 103;
   103, 112, 108;
   102, 106,  93;
   111, 102, 108;
    93,  98,  79;
    79,  89,  72;
    72,  82,  67;
    67,  78,  60;
    43,  37,  33;
    49,  43,  60;
    33,  28,  26;
    26,  22,  20;
    20,  15,  14;
    14,   8,   9;
    59,  56,  70;
    47,  59,  52;
    70,  66,  81;
    62,  71,  53;
    71,  80,  61;
    80,  94,  74;
    94, 103,  81;
   102,  93,  84;
    93,  79,  73;
    79,  72,  64;
    72,  67,  57;
    43,  33,  45;
    33,  26,  36;
    26,  20,  27;
    20,  14,  23;
    59,  70,  73;
    73,  70,  84;
    59,  73,  64;
    84,  70,  81;
    59,  64,  52;
    84,  81,  97;
    52,  64,  57;
    52,  57,  45;
    97,  81, 103;
    84,  97, 102;
   102,  97, 108;
   108,  97, 103;
    47,  52,  36;
    81,  66,  74;
    74,  66,  61;
    74,  94,  81;
    80,  74,  61;
    84,  93,  73;
    73,  79,  64;
    64,  72,  57;
    57,  67,  51;
    45,  33,  36;
    43,  45,  51;
    43,  51,  60;
    51,  45,  57;
    51,  67,  60;
    45,  36,  52;
    58,  62,  46;
    14,   9,  18 ];
%
% Fixed Nodes
%
fixnodes = [
     85  , 1 ,    0.00000  ;
     85  , 2 ,    0.00000  ;
    121  , 1 ,    0.00000  ;
    121  , 2 ,    0.00000  ] ;
%
% Point loads
%
pointload = [ ] ;
%
% Side loads
%
sideload = [ ];