function fitOpt = parseHyperparameters(fitOpt,fitFcn,hyper,options)
%PARSEHYPERPARAMETERS	Parse hyperparameters
%	fitOpt = parseHyperparameters(fitOpt,fitFcn,hyper,options)
%	Update fitOpt with the given hyperparameters.
%
%	Inputs:
%		fitOpt - Options for the fitness function.
%		fitFcn - The fitness function
%		hyper  - The genome coding for the new hyperparameters
%		options - Stores info on the number of bits coding for each hyper
%
%	Outputs:
%		fitOpt - Options for the fitness function updated with new params

%	$Author: Alistair Johnson$
%	$Revision: 1.0.0.0$
%	$Date: 21-Jun-2013 15:10:09$
%	Contact: alistairewj@gmail.com
%	Originally written on: GLNXA64

%	Copyright 2013 Alistair Johnson

% TODO: How do I ensure hyperparameter order in fieldnames is OK? Check it
% is conserved.
%%
fn = fieldnames(options.Hyperparameters);
idxBit = 1;
for k=1:numel(fn)
    
    curr_val = hyper(idxBit:idxBit+options.Hyperparameters.(fn{k}).bitsNeeded-1);
    curr_val = feval(options.Hyperparameters.(fn{k}).fcn,curr_val);
    curr_val = curr_val + options.Hyperparameters.(fn{k}).offset;
    
    fitOpt.(fn{k}) = curr_val;
    
    idxBit = idxBit+options.Hyperparameters.(fn{k}).bitsNeeded;
end

end

%=== Convert binary numbers into integers
function [ curr_val ] = mybin2dec(curr_val)
curr_val = 2.^(0:numel(curr_val)-1).*curr_val;
% sum 2.^0, 2.^1 ... (creates dec number from binary)
% also add the offset value for the range
curr_val = sum(curr_val);
end


%=== Convert binary numbers into integers
function [ curr_val ] = mybin2decfrac(curr_val)
MIN_EXP = -2;
curr_val = 2.^(MIN_EXP:numel(curr_val)-1+MIN_EXP).*curr_val;
% sum 2.^0, 2.^1 ... (creates dec number from binary)
% also add the offset value for the range
curr_val = sum(curr_val);
end