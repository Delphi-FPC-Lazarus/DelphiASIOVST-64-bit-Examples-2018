object VSTOpAmp: TVSTOpAmp
  OldCreateOrder = False
  Flags = [effFlagsHasEditor, effFlagsCanReplacing, effFlagsCanDoubleReplacing]
  Version = '1.0'
  EffectName = 'Simple OpAmp Simulation'
  ProductName = 'DAV Effect Examples'
  VendorName = 'Delphi ASIO & VST Project'
  PlugCategory = vpcEffect
  CanDos = [vcdPlugAsChannelInsert, vcdPlugAsSend, vcd1in1out, vcd1in2out, vcd2in1out, vcd2in2out]
  SampleRate = 44100.000000000000000000
  CurrentProgramName = 'Init'
  IORatio = 1.000000000000000000
  UniqueID = 'NoLi'
  ShellPlugins = <>
  Programs = <
    item
      DisplayName = 'Init'
      VSTModule = Owner
    end>
  ParameterProperties = <
    item
      CurveFactor = 1.000000000000000000
      DisplayName = 'Gain'
      Flags = [ppfParameterUsesIntegerMinMax, ppfParameterSupportsDisplayIndex]
      LargeStepFloat = 2.000000000000000000
      LargeStepInteger = 2
      Max = 20.000000000000000000
      MaxInteger = 20
      Min = -40.000000000000000000
      MinInteger = -40
      ReportVST2Properties = True
      ShortLabel = 'Gain'
      SmallStepFloat = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      Units = 'dB'
      VSTModule = Owner
    end>
  ParameterCategories = <>
  OnOpen = VSTModuleOpen
  OnEditOpen = VSTModuleEditOpen
  OnParameterChange = VSTModuleParameterChange
  OnProcess = VSTModuleProcess
  OnProcess32Replacing = VSTModuleProcess
  OnProcess64Replacing = VSTModuleProcessDoubleReplacing
  Height = 150
  Width = 215
end
