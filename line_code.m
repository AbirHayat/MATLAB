% =========================================================
% Line Coding Visualization for Binary Sequence: 10010110
% Schemes:
%   i) Bipolar AMI
%   ii) Polar RZ
%   iii) Manchester NRZ
%   iv) Differential Manchester NRZ
% =========================================================

clear;
clc;
close all;

%% ---------------- INPUT DATA ----------------
bits = [1 0 0 1 0 1 1 0];
num_bits = length(bits);

samples_per_bit = 100;     % Smooth digital waveform
total_samples = num_bits * samples_per_bit;

% Time axis
t = (0:total_samples-1) / samples_per_bit;

%% ---------------- SIGNAL ARRAYS ----------------
ami  = zeros(1, total_samples);
rz   = zeros(1, total_samples);
man  = zeros(1, total_samples);
dman = zeros(1, total_samples);

%% ---------------- INITIAL CONDITIONS ----------------
ami_level = 1;          % First AMI '1' starts positive
prev_diff_level = -1;  % Initial level for Differential Manchester

%% ====================================================
%                ENCODING SECTION
% =====================================================

for i = 1:num_bits
    
    % ----- Index ranges -----
    idx = (i-1)*samples_per_bit + 1 : i*samples_per_bit;

    first_half = (i-1)*samples_per_bit + 1 : ...
                 (i-1)*samples_per_bit + samples_per_bit/2;

    second_half = (i-1)*samples_per_bit + ...
                  samples_per_bit/2 + 1 : i*samples_per_bit;

    %% -------------------------------------------------
    % i) Bipolar AMI
    % 1 -> alternating +V and -V
    % 0 -> 0V
    %% -------------------------------------------------

    if bits(i) == 1
        ami(idx) = ami_level;
        ami_level = -ami_level;   % Alternate polarity
    else
        ami(idx) = 0;
    end

    %% -------------------------------------------------
    % ii) Polar RZ
    % 1 -> +V then return to 0
    % 0 -> -V then return to 0
    %% -------------------------------------------------

    if bits(i) == 1
        rz(first_half) = 1;
    else
        rz(first_half) = -1;
    end

    rz(second_half) = 0;

    %% -------------------------------------------------
    % iii) Manchester Encoding
    % IEEE 802.3 Convention:
    % 1 -> Low to High
    % 0 -> High to Low
    %% -------------------------------------------------

    if bits(i) == 1
        man(first_half)  = -1;
        man(second_half) =  1;
    else
        man(first_half)  =  1;
        man(second_half) = -1;
    end

    %% -------------------------------------------------
    % iv) Differential Manchester
    %
    % Rules:
    % - Always transition at middle of bit
    % - 0 -> transition at beginning
    % - 1 -> NO transition at beginning
    %% -------------------------------------------------

    if bits(i) == 0
        start_level = -prev_diff_level;
    else
        start_level = prev_diff_level;
    end

    mid_level = -start_level;

    dman(first_half)  = start_level;
    dman(second_half) = mid_level;

    prev_diff_level = mid_level;

end

%% ====================================================
%                    PLOTTING
% =====================================================

figure('Name','Line Coding Techniques',...
       'Position',[200 100 1000 750]);

bit_labels = {'','1','0','0','1','0','1','1','0'};

%% ---------------- Bipolar AMI ----------------

subplot(4,1,1)

stairs(t, ami, 'LineWidth', 2.5)

grid on
ylim([-1.5 1.5])
xlim([0 num_bits])

title('i) Bipolar AMI','FontSize',11)

ylabel('Voltage')

xticks(0:num_bits)
xticklabels(bit_labels)

yticks([-1 0 1])

%% ---------------- Polar RZ ----------------

subplot(4,1,2)

stairs(t, rz, 'LineWidth', 2.5)

grid on
ylim([-1.5 1.5])
xlim([0 num_bits])

title('ii) Polar RZ','FontSize',11)

ylabel('Voltage')

xticks(0:num_bits)
xticklabels(bit_labels)

yticks([-1 0 1])

%% ---------------- Manchester ----------------

subplot(4,1,3)

stairs(t, man, 'LineWidth', 2.5)

grid on
ylim([-1.5 1.5])
xlim([0 num_bits])

title('iii) Manchester NRZ (IEEE 802.3)','FontSize',11)

ylabel('Voltage')

xticks(0:num_bits)
xticklabels(bit_labels)

yticks([-1 0 1])

%% ------------ Differential Manchester ------------

subplot(4,1,4)

stairs(t, dman, 'LineWidth', 2.5)

grid on
ylim([-1.5 1.5])
xlim([0 num_bits])

title('iv) Differential Manchester NRZ','FontSize',11)

ylabel('Voltage')
xlabel('Bit Intervals / Time')

xticks(0:num_bits)
xticklabels(bit_labels)

yticks([-1 0 1])

%% ====================================================
% End of Script
% ====================================================