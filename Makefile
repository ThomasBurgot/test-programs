# MAKE SURE TO EXPORT INSTALLDIR BEFORE CALLING MAKE!


all:
	dwarf_bifft_sp dwarf_bifft_dp driver-spectraltransform_dp driver-spectraltransform_sp
	
driver-spectraltransform_dp: driver-spectraltransform.F90
	mpif90 -I${INSTALLDIR}/ectrans/include/ectrans -I${INSTALLDIR}/fiat/include/fiat \
		-I${INSTALLDIR}/ectrans/module/trans_gpu_static_CA_dp -I${INSTALLDIR}/fiat/module/fiat \
		-I${INSTALLDIR}/fiat/module/parkind_dp \
		-O0 -g -acc -Minfo=acc -gpu=cc70,lineinfo,deepcopy,fastmath,nordc -fpic \
		driver-spectraltransform.F90 -o driver-spectraltransform_dp \
		-lgpu -cudalib=cufft,cublas -lnvToolsExt \
		-L${INSTALLDIR}/fiat/lib64/ -lfiat -lparkind_dp -L${INSTALLDIR}/ectrans/lib64/ -ltrans_gpu_static_CA_dp -lgpu \
		-L${INSTALLDIR}/nvtx/lib -lnvtx -lblas -llapack
		
driver-spectraltransform_sp: driver-spectraltransform.F90
	mpif90 -I${INSTALLDIR}/ectrans/include/ectrans -I${INSTALLDIR}/fiat/include/fiat \
		-I${INSTALLDIR}/ectrans/module/trans_gpu_static_CA_sp -I${INSTALLDIR}/fiat/module/fiat \
		-I${INSTALLDIR}/fiat/module/parkind_sp \
		-O0 -g -acc -Minfo=acc -gpu=cc70,lineinfo,deepcopy,fastmath,nordc -fpic \
		driver-spectraltransform.F90 -o driver-spectraltransform_sp \
		-lgpu -cudalib=cufft,cublas -lnvToolsExt \
		-L${INSTALLDIR}/fiat/lib64/ -lfiat -lparkind_sp -L${INSTALLDIR}/ectrans/lib64/ -ltrans_gpu_static_CA_sp -lgpu \
		-L${INSTALLDIR}/nvtx/lib -lnvtx -lblas -llapack


dwarf_bifft_sp: dwarf_bifft.F90
	mpif90 -I${INSTALLDIR}/etrans/include/etrans -I${INSTALLDIR}/ectrans/include/ectrans -I${INSTALLDIR}/fiat/include/fiat \
		-I${INSTALLDIR}/ectrans/module/trans_gpu_static_CA_sp -I${INSTALLDIR}/etrans/module/etrans_sp -I${INSTALLDIR}/fiat/module/fiat \
		-I${INSTALLDIR}/fiat/module/parkind_sp \
		-O2 -g -traceback -acc -Minfo=acc -gpu=cc70,lineinfo,deepcopy,fastmath,nordc -fpic \
		dwarf_bifft.F90 -o dwarf_bifft_sp \
		-L${INSTALLDIR}/etrans/lib64/ -letrans_sp \
		-L${INSTALLDIR}/ectrans/lib64/ -ltrans_gpu_static_CA_sp -lgpu -L${INSTALLDIR}/fiat/lib64/ -lfiat -lparkind_sp \
		-L${INSTALLDIR}/nvtx/lib -lnvtx -cudalib=cufft,cublas -lnvToolsExt -lblas -llapack


dwarf_bifft_dp: dwarf_bifft.F90
	mpif90 -I${INSTALLDIR}/etrans/include/etrans -I${INSTALLDIR}/ectrans/include/ectrans -I${INSTALLDIR}/fiat/include/fiat \
		-I${INSTALLDIR}/ectrans/module/trans_gpu_static_CA_dp -I${INSTALLDIR}/etrans/module/etrans_dp -I${INSTALLDIR}/fiat/module/fiat \
		-I${INSTALLDIR}/fiat/module/parkind_dp \
		-O2 -g -traceback -acc -Minfo=acc -gpu=cc70,lineinfo,deepcopy,fastmath,nordc -fpic \
		dwarf_bifft.F90 -o dwarf_bifft_dp \
		-L${INSTALLDIR}/etrans/lib64/ -letrans_dp \
		-L${INSTALLDIR}/ectrans/lib64/ -ltrans_gpu_static_CA_dp -lgpu -L${INSTALLDIR}/fiat/lib64/ -lfiat -lparkind_dp \
		-L${INSTALLDIR}/nvtx/lib -lnvtx -cudalib=cufft,cublas -lnvToolsExt -lblas -llapack

clean:
	rm -f  dwarf_bifft_sp dwarf_bifft_dp driver-spectraltransform_dp driver-spectraltransform_sp