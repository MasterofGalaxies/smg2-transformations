# brkirch's Super Mario Galaxy 2 Transformations Gecko code

## Compiling

[PyiiASMH](https://github.com/JoshuaMKW/pyiiasmh) can be used to compile transformations.s into a Gecko code.

## Usage

Button 2 cycles through this transformation list:

* Flying Mario
* Cloud Mario
* Rock Mario
* Rainbow Mario
* Fire Mario
* Bee Mario
* Spring Mario
* Boo Mario

Button 1 applies/unapplies the selected transformation if it is loaded.  Holding button 2 and then pressing button 1 once resets the selected transformation to the the beginning of the transformation list.  Holding button 2 and then pressing button 1 twice toggles whether transformation enhancers are applied.  Holding button 2 and then pressing button 1 three times toggles whether the selected transformation is always loaded (to select a transformation which is not set to always be loaded, go to Starship Mario).

The only transformation that is always available by default is Flying Mario.  Other transformations will only be loaded if the game requires it for the current galaxy or if they are manually toggled on from Starship Mario.

## Ice Mario

Ice Mario can be enabled by setting `enableIceMario` to `true`, upon which the transformation list becomes:

* Flying Mario
* Cloud Mario
* Rock Mario
* Rainbow Mario
* Fire Mario
* Ice Mario
* Bee Mario
* Spring Mario
* Boo Mario

This requires that the files IceMario.arc, IceLuigi.arc, IceMarioHandL.arc, IceMarioHandR.arc, and IceStep.arc from Super Mario Galaxy 1 \(copies of which are in this repository\) be made available to the game in /ObjectData/. \(PowerUpIce.arc, the ObjectData file for the Ice Flower, is not required for use with this code, nor is IceMarioMat.arc.\)

## Demonstration

A video of this code in use can be found here: https://www.youtube.com/watch?v=EUBR_TnGrvs

## Credits

Credit for this code goes to brkirch. Additional credit goes to hetoan2 for:

* Powers Last Forever \[hetoan2\]
* Infinite Bee Mario Flight \[hetoan2\]
