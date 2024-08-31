# LTI Circuit Analysis Using Differential-Integral Equations

This repository contains MATLAB code and a report that documents the analysis of linear time-invariant (LTI) circuits characterized by differential-integral equations. The project includes the derivation of differential equations governing circuit behavior, the determination of impulse and frequency responses, and the exploration of minimal differential equations for the systems.


## Repository Structure

. ├── code │ ├── convert_to_differential.m │ ├── extract_power.m │ ├── find_frequency_response.m │ ├── find_impulse_response.m │ ├── findMinimalDiffEq.m │ ├── solve_circuit.m │ └── solver.m ├── report.pdf └── README.md


### `code`

- **convert_to_differential.m**: Converts the D-operator form of the differential equation into a standard differential equation form using MATLAB symbolic computation.
- **extract_power.m**: Auxiliary function used to handle power extraction in the D-operator during the conversion process.
- **find_frequency_response.m**: Computes the frequency response of the circuit, providing both the amplitude and phase responses across a range of frequencies.
- **find_impulse_response.m**: Computes the impulse response of the circuit by solving the differential equation with a Dirac delta function as input.
- **findMinimalDiffEq.m**: Derives the minimal differential equation governing the system using balanced truncation and model reduction techniques.
- **solve_circuit.m**: Implements the main methodology for solving the circuit's differential equation using Cramer's rule, producing the differential equation relating the desired circuit variable to the input.
- **solver.m**: The main script where the entries for the circuit are defined and the various analysis functions are called.


### `report.pdf`

The report, titled "Analysis of LTI Circuits with Differential-Integral Equations," provides a detailed explanation of the theoretical background, methodology, and results obtained from the MATLAB code. It includes:

- **Theoretical Background**: Explains the use of D-operators and the methodology for deriving differential equations.
- **Impulse Response Analysis**: Details the calculation of the circuit's impulse response and provides examples and plots.
- **Frequency Response Analysis**: Details the calculation of the circuit's frequency response and provides examples and plots.
- **Minimal Differential Equation**: Discusses the concept and derivation of the minimal differential equation representing the system.

[Download the report](https://github.com/mahdi-shokrzadeh/circuit-analysis/raw/main/report/report.pdf)


## How to Use

1. **Set Up MATLAB**: Ensure you have MATLAB installed on your system to run the scripts.
2. **Define Circuit Parameters**: Modify the `solver.m` file to input the specific parameters of your circuit, including the matrices `A`, `Y`, and `W`.
3. **Run the Solver**: Execute `solver.m` to perform the analysis. The script will call the relevant functions to derive the differential equation, impulse response, and frequency response of the circuit.
4. **Review Results**: The results, including plots and differential equations, will be output directly in the MATLAB workspace. 


## Example Usage

Here’s how you can analyze a simple parallel RLC circuit using this repository:

```matlab
% Example setup for a parallel RLC circuit
A = [1/(L*D) + 1/R + C*D];
W = [is(t)];
m = 1; % Desired output variable index

% Solve for the differential equation
eq = solve_circuit(A, W, m);

% Convert to standard differential form
diff_eq = convert_to_differential(eq);

% Find the impulse response
h_t = find_impulse_response(diff_eq);

% Find the frequency response
H_jw = find_frequency_response(diff_eq);
```


This work was done as part of the Electrical Circuits course taught by [Dr. Hadi](https://ir.linkedin.com/in/mohammad-hadi-305a69102).
