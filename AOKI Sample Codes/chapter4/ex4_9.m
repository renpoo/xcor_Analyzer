clear;
fs=8000;
lpc_order=10;
lsp=[656.3 710.9 972.7 1056.6 1363.3 2543.0 2750.0 3002.0 3384.8 3433.6];
lpc=LspToLpc_(lsp,lpc_order,fs);
