int ASIOInitDriver(char *DriverName);
int ASIOInitDriverIndex(int Index);
int ASIOGetNumDevices;
int ASIOSetDriverIndex(int Index);
char* ASIOGetDriverName(int Index);
int ASIOGetDriverNames(char *Names, int lmaxDriverAnzahl, int lDriverNumber);
int ASIODriverStart;
int ASIODriverStop;
int ASIOGetBufferSize(int *minSize, int *maxSize, int *preferredSize, int *granularity);
int ASIOControlPanel;
int ASIOCanSampleRate(double SampleRate);
int ASIOSetSampleRate(double SampleRate);
int ASIOGetChannels(int *InputChannels, int *OutputChannels);
int ASIOOutputType(int Index);
int ASIOSetOutputVolume(int Channel, float Volume);
int ASIOSetOutputVolumedB(int Channel, float Volume);
int ASIOSetSineFrequency(int Channel, float Frequency);
float ASIOGetInputLevel(int Channel);
float ASIOGetOutputLevel(int Channel);
int ASIOReadWriteSize;
int ASIOReadWriteSizeFixed;
int ASIOReadWrite(double *Buffer, int Length, int Channel);
int ASIOReadWriteX(void *Buffer, int Length);
int ASIOAutopilot(void *Buffer, int Length);
int ASIOSetExtraBufferSize(int Size);
int ASIOBufferUnderrun;
void ASIOResetBufferUnderruns;
int ASIOGetLoopCounts;
void ASIOSetLoopCounts(int Loops);
int ASIOSetClipFunction(int ClipFunction);
void ASIOCalcMeters(int CalcMeters);