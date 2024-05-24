# Emotion Recognition Application Using Words with Fuzzy Logic

Welcome to the Emotion Recognition Application based on Fuzzy Logic!

This repository contains a MATLAB-based application designed to recognize emotions from text data using fuzzy logic models. It supports both English and Italian datasets, offering a flexible approach to emotion recognition in different languages.

## Prerequisites

Before using this application, ensure you have MATLAB installed on your computer. You can download MATLAB from the official MathWorks website: [Download MATLAB](https://www.mathworks.com/downloads/).

## Repository Structure

The repository is organized into the following main folders:

- `eng/`: Contains the application for using the fuzzy model on English language datasets.
- `ita/`: Contains the application for using the fuzzy model on Italian language datasets.

## Usage

### English Application

To use the emotion recognition application on English language datasets and calculate the accuracy of the fuzzy logic model, follow these steps:

1. Open MATLAB on your computer.
2. Navigate to the `eng/` folder.
3. Run the following command in the MATLAB *Command Window*:
   ```matlab
   run main.m
   
This will initiate the emotion recognition process for English text data, applying the fuzzy logic model and displaying the accuracy results.

### Italian Application

To use the emotion recognition application on Italian language datasets and analyze phrases directly as input and output the analysis, follow these steps:
1. Open MATLAB on your computer.
2. Navigate to the `ita/` folder.
3. Run the following command in the MATLAB *Command Window*:
   ```matlab
   run main_ita.m

This will start the emotion recognition process for Italian text data, allowing you to input phrases and receive immediate emotional analysis results based on the fuzzy logic model.

## How It Works
The Emotion Recognition application leverages fuzzy logic to interpret and classify emotions from textual data. Here’s a brief overview of how it functions:

1. **Data Input**: The application accepts text data in English or Italian, depending on the chosen module.
2. **Fuzzy Logic Model**: The core of the application is a fuzzy logic system that processes the input data. Fuzzy logic is used to handle the uncertainty and imprecision inherent in natural language, making it suitable for emotion recognition tasks.
3. **Emotion Analysis**: The fuzzy logic model evaluates the input text and assigns an emotional category based on predefined rules and membership functions.
4. **Output**: For English datasets, the application calculates and displays the model's accuracy. For Italian datasets, it directly outputs the emotional analysis of the input phrases.

## Getting Started
To get started with the Emotion Recognition application:

1. Clone the repository to your local machine:
  ```matlab
  git clone https://github.com/yourusername/emotion-recognition-matlab.git
  ```
2. Follow the usage instructions for either the English or Italian application as detailed above.

## Contributing
Contributions to this project are welcome! If you have any suggestions, bug reports, or improvements, please open an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.




