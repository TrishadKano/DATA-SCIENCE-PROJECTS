# -*- coding: utf-8 -*-
"""
Created on Fri May 23 10:10:25 2025

@author: TrishadP
"""


import numpy as np
import pickle
import streamlit as st

# Load the saved model
loaded_model = pickle.load(open(
    r"C:\Users\trishadp\OneDrive - mintek.co.za\Desktop\My WORK\MACHINE LEARNING\trained_model.sav",
    'rb'
))

# Prediction function
def diabetes_prediction(input_data):
    input_data_as_numpy_array = np.asarray(input_data).reshape(1, -1)
    prediction = loaded_model.predict(input_data_as_numpy_array)
    
    if prediction[0] == 0:
        return 'The person is not diabetic'
    else:
        return 'The person is diabetic'

# Main Streamlit function
def main():
    # Title
    st.title('Diabetes Prediction Web App')

    # Input fields using number_input
    with st.form("diabetes_form"):
        col1, col2 = st.columns(2)
        with col1:
            Pregnancies = st.number_input('Number of Pregnancies', min_value=0, step=1)
            BloodPressure = st.number_input('Blood Pressure Value', min_value=0)
            Insulin = st.number_input('Insulin Level', min_value=0)
            DiabetesPedigreeFunction = st.number_input('Diabetes Pedigree Function value', min_value=0.0, format="%.3f")
        with col2:
            Glucose = st.number_input('Glucose Level', min_value=0)
            SkinThickness = st.number_input('Skin Thickness value', min_value=0)
            BMI = st.number_input('BMI value', min_value=0.0, format="%.1f")
            Age = st.number_input('Age of the Person', min_value=1, step=1)

        # Submit button
        submitted = st.form_submit_button("Diabetes Test Result")
    
    # Prediction logic
    diagnosis = ''
    if submitted:
        input_data = [
            Pregnancies, Glucose, BloodPressure,
            SkinThickness, Insulin, BMI,
            DiabetesPedigreeFunction, Age
        ]
        diagnosis = diabetes_prediction(input_data)
        st.success(diagnosis)

# Run the app
if __name__ == '__main__':
    main()