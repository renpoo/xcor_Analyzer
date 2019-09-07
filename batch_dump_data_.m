function batch_dump_data_( handles )

dump_data_( handles.results.PHI_ll_0Mat,  'PHI_ll_0Mat',  handles );
dump_data_( handles.results.PHI_rr_0Mat,  'PHI_rr_0Mat',  handles );
dump_data_( handles.results.PHI_lrMat,    'PHI_lrMat',    handles );
dump_data_( handles.results.phi_lrMat,    'resultMat',    handles );

dump_data_( handles.results.timeAxis,     'timeAxis',     handles );
dump_data_( handles.results.tauAxis,      'tauAxis',      handles );

dump_data_( handles.results.maxValuesMat, 'maxValuesMat', handles );
dump_data_( handles.results.maxIdxsMat,   'maxIdxsMat',   handles );
dump_data_( handles.results.maxTimesMat,  'maxTimesMat',  handles );
dump_data_( handles.results.zeroIdxsMat,  'zeroIdxsMat',  handles );

dump_data_( handles.results.ICCCMat,      'ICCCMat',      handles );
dump_data_( handles.results.tauICCCMat,   'tauICCCMat',   handles );
dump_data_( handles.results.WicccMat,     'WicccMat',     handles );
dump_data_( handles.results.tauAlphaMat,  'tauAlphaMat',  handles );
dump_data_( handles.results.tauBetaMat,   'tauBetaMat',   handles );

dump_data_( handles.results.dateTime,     'dateTime',     handles );

dump_data_( handles.results.tauE_Vec_R,          'tauE_Vec_R',          handles );
dump_data_( handles.results.env_tauE_Vec_R,      'env_tauE_Vec_R',      handles );
dump_data_( handles.results.grad_env_tauE_Vec_R, 'grad_env_tauE_Vec_R', handles );

dump_data_( handles.results.tauE_Vec_L,          'tauE_Vec_L',          handles );
dump_data_( handles.results.env_tauE_Vec_L,      'env_tauE_Vec_L',      handles );
dump_data_( handles.results.grad_env_tauE_Vec_L, 'grad_env_tauE_Vec_L', handles );


end
