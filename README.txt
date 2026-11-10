Brandt LandRoller 591A Standalone - 1.2.0.0

Shop: Rollers > Tool type: Land roller / Grass roller / Mulcher.
Land roller: original smooth drums and soil rolling.
Grass roller: original smooth drums and grassland rolling.
Mulcher: five shiny black bladed drums, silver bolts, passive mulching while driving unfolded with ground contact.
All modes: independent Main color and Rim color shop options with the full native palette.
Defaults: base-game Brandt blue frame and original rim finish. Brandt blue is explicitly available.
Only the original blue-painted frame material follows Main color; drums, bolts, hoses and hardware retain their finishes.
Original transport wheels, folding, hitch and physics are retained.
Working width 27.7 m; required power 275 hp; speed 14 km/h; price 115,000. Mode options have no surcharge.

Build destination requested: Testing_local only. ZIP: FS25_Brandt_LandRoller591A.zip.
Do not package source, backups, research, previews, QA tools or logs.
Runtime manifest: source/build_1_1_1_0/runtime_files.txt.

New drum geometry compiled with the installed GIANTS i3dConverter; original protected game shape file retained unchanged.
Own drum assets use supported I3D references. Mulcher config hides original smooth drum surfaces through dedicated identity skin-bone children.
The native motion nodes drive both original and replacement drums at unit scale; each mode selects surface visibility.
Five separate replacement speedRotatingPart entries have been removed. Drum geometry and fit are unchanged.
Field/grass configurations restore original drums. Native roller work areas switch to mulcher type and native density-map mulching only in mode 3.
Unchanged base-game textures/effects use $data references.

1.1.0.0 validation: GIANTS TestRunner PASS all modules. User confirmed FIELD/GRASS in locally hosted multiplayer; MULCHER alignment failed in shop.
1.1.1.0 source correction: validation results are under source/build_1_1_1_0. Corrected shop/purchase/folding behavior still requires game verification.

Original vehicle assets: GIANTS Software. Mulcher drums and standalone conversion: PropaineX.

1.1.2.0: enabled runtime loading on the five replacement-drum ReferenceNodes.
User screenshot confirms 1.1.1.0 failed to display bladed replacement drums in shop.
Corrected runtime appearance and original-drum hiding still require game verification.

1.1.3.0: removed ineffective stock-drum shrink scales and inverse replacement scales.
Five identity StockSkin children preserve original skin-slot transforms and allow hiding only smooth drum surfaces.
Corrected runtime visibility still requires game verification.

1.1.4.0: restored the original meadowRollerWork sound at the configuration-specific paths used by native Roller:onLoad.
All drum-loading/visibility/motion changes remain exactly as1.1.3.0.
Pre-game code review: source/build_1_1_4_0/review/.

1.2.0.0: main/rim paint configurations added at no surcharge for all3 tool modes.
Native color configuration IDs handle save/reload and multiplayer selection; wheel rims use native Wheels support.

1.3.0.0: Grass roller now uses own spiral-bead drums (from scratch, PropaineX): exact native drum size (r 0.5334 m, centre 4.5720 m, wings 5.9434 m,
native end profile) with a raised 9 mm weld bead spiralling the full length, 1.80 m per wrap. Same swap as Mulcher (StockSkin hidden, spiralCenter/spiralWing shown).
Land roller and Mulcher unchanged. Source: Library/_SpiralBeadDrum, source/build_1_3_0_0. In-game look/alignment still requires game verification.

1.4.0.0: Land roller (FIELD) now uses own black ring-roller drums (from scratch, PropaineX; Library/_RingRollerDrum): strictly alternating
fat finned rings and skinny toothed rings (centre 17+16, wings 22+21), tooth tips at the native drum radius 0.5334 m, native lengths and axle stubs.
Same swap as Grass/Mulcher (StockSkin hidden, ringCenter/ringWing shown). Grass roller and Mulcher unchanged. In-game look still requires game verification.

1.4.1.0: new mod icon + store image showing all three shop versions: Land roller (blue, ring drums), Grass roller (green, spiral drums), Mulcher (orange). Store image has a clear background.
