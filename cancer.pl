symptom(lump_under_arm_or_breast, 'breast cancer').
symptom(change_in_size_or_shape_of_breast, 'breast cancer').
symptom(nipple_discharge, 'breast cancer').
symptom(nipple_turned_inward, 'breast cancer').
symptom(sore_around_nipple_area, 'breast cancer').
symptom(skin_irritation_on_breast, 'breast cancer').
symptom(constant_pain_in_breast, 'breast cancer').

diagnosis(imaging_tests, 'breast cancer').
diagnosis(biopsy, 'breast cancer').
diagnosis(genomic_tests, 'breast cancer').
diagnosis(magnetic_resonance_imaging, 'breast cancer').
diagnosis(blood_tests, 'breast cancer').

has_breast_cancer(Symptoms, Diagnoses) :-
    findall(Symptom, (member(Symptom, Symptoms), symptom(Symptom, 'breast cancer')), FoundSymptoms),
    length(FoundSymptoms, SymptomCount),
    SymptomCount >= 3,
    findall(Diagnosis, (member(Diagnosis, Diagnoses), diagnosis(Diagnosis, 'breast cancer')), FoundDiagnoses),
    length(FoundDiagnoses, DiagnosisCount),
    DiagnosisCount >= 2,
    SymptomsAndDiagnoses = [FoundSymptoms, FoundDiagnoses],
    flatten(SymptomsAndDiagnoses, AllFound),
    sort(AllFound, UniqueFound),
    length(UniqueFound, UniqueCount),
    length(SymptomsAndDiagnoses, InputCount),
    InputCount =< UniqueCount,
    % Termination condition 1: Ensure that the length of UniqueFound list is finite
    length(UniqueFound, UniqueCount),
    % Termination condition 2: Ensure that InputCount is less than or equal to UniqueCount
    InputCount =< UniqueCount,
    % Termination condition 3: Ensure that UniqueCount is finite
    % Termination condition 4: Ensure that UniqueCount is equal to the sum of SymptomCount and DiagnosisCount
    (UniqueCount =:= SymptomCount + DiagnosisCount ->
        % Output the result
        write('You have breast cancer.');
        write('You do not have breast cancer.')).

