% Rainwater Harvesting Potential Estimation
% This MATLAB script estimates the potential volume of rainwater that can be harvested
% from a rooftop, using simulated monthly rainfall data and a runoff coefficient. 
% The model accounts for different environmental factors such as rainfall distribution,
% runoff characteristics, and rooftop area to provide an estimate of the harvestable water volume.
% The results are visualized in a bar plot, which helps in understanding how variations in 
% rooftop area and rainfall impact water collection efficiency, a crucial aspect in sustainable water management.
%
% This tool serves as a practical approach for environmental engineers to design and optimize
% rainwater harvesting systems in water-scarce regions.
% Author: Irakoze Kelly | Date: November 2024


clear; close all; clc;

% Input Parameters
area_range = 50:50:500;  % Rooftop areas from 50 to 500 m^2
rainfall_data = [80, 75, 100, 120, 130, 150, 160, 150, 130, 120, 90, 85];  % Example monthly rainfall in mm
runoff_coefficient = 0.8;  % Default runoff coefficient
evaporation_factor = 0.15;  % 15% loss due to evaporation
catchment_efficiency = 0.9;  % 90% efficiency
isGreenRoof = false;  % Flag for green roof
dry_season_months = 4;  % Dry season duration in months

% Seasonal variation in runoff coefficient
runoff_coefficients = [0.8, 0.85, 0.75, 0.7, 0.75, 0.9, 0.95, 0.8, 0.85, 0.9, 0.95, 0.8];

% Calculate Harvested Water
harvested_water = calculate_harvested_water(rainfall_data, area_range, runoff_coefficients, evaporation_factor, catchment_efficiency);

% Plotting
figure;
bar(area_range, harvested_water, 'FaceColor', [0.2, 0.6, 0.2]);
xlabel('Rooftop Area (m^2)');
ylabel('Harvested Water (m^3)');
title('Harvested Water vs Rooftop Area');
grid on;

% Table Output
disp('Harvested Water (m^3) for Each Rooftop Area:');
T = table(area_range', harvested_water', 'VariableNames', {'Rooftop_Area_m2', 'Harvested_Water_m3'});
disp(T);

% Function to Calculate Harvested Water
function harvested_water = calculate_harvested_water(rainfall_data, area_range, runoff_coefficients, evaporation_factor, catchment_efficiency)
    % Convert monthly rainfall data from mm to meters
    rainfall_data_meters = rainfall_data / 1000;
    
    % Calculate total rainfall for the year (in meters)
    total_rainfall = sum(rainfall_data_meters);
    
    % Initialize harvested_water array
    harvested_water = zeros(length(area_range), 1);

    % Calculate harvested water for each rooftop area
    for i = 1:length(area_range)
        area = area_range(i);
        runoff_coefficient = runoff_coefficients(i);  % Seasonal variation
        harvested_water(i) = total_rainfall * area * runoff_coefficient * (1 - evaporation_factor) * catchment_efficiency;
    end
end

