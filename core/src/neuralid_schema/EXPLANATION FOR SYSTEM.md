.md
```

PANE FRONTEND OF A NODE This one for Audio
Will load a series of Widgets that are relevant for it..
It is the UI COUNTER PART To N in the BACKEND 

*********************


```markdown
. 📂 GAN
└── 📂 GANAC/
│  ├── 📄 GANAC-00000000000000000000000000.fbs
│  ├── 📄 GANAC-index.fbs
│  ├── 📄 GANAC_BrainJob-00000000000000000000000000.fbs
│  ├── 📄 GANAC_DecayRule-00000000000000000000000000.fbs
│  ├── 📄 GANAC_VectorDoll-00000000000000000000000000.fbs
├── 📄 GAN_Integarigation-00000000000000000000000000.fbs
└── 📄 GAN_index.fbs
```

A pane have CONNECTORS IN on the TOP AND LEFT SIDE and OUT connectors on the BOTTOM AND RIGHT SIDE.

CONNECTOR SLOT ON PANES CONAU is for OUT AND AUDIO
```markdown
. 📂 C
└── 📂 COU/
│  └── 📂 COUAU/
│    ├── 📄 ARCHTYPES
├── 📄 C_index.fbs
└── 📂 IN/
└── 📄 TYPES.md
```
********************
********************
MANAGER IS the thing that control all panes and nodes. 
It will always create Panes and Nodes in Pairs.
What is special about it is it have a UI for both launching in a NODE Version {blueprint }and in a Controller{ActiveFrame}

```markdown
. 📂 X
├── 📄 TYPES.md
└── 📂 XAM/
│  ├── 📄 ARCHTYPES.md
│  └── 📂 XAMCM/
│    ├── 📄 XAMCM-00000000000000000000000000.fbs
│    ├── 📄 XAMCM-index.fbs
│    ├── 📄 XAMCM.qml
│    ├── 📄 XAMCM_BrainJob-00000000000000000000000000.fbs
│    ├── 📄 XAMCM_DecayRule-00000000000000000000000000.fbs
│    ├── 📄 XAMCM_VectorDoll-00000000000000000000000000.fbs
└── 📄 X_index.fbs
```

*****************
*****************

** this is the anchorpoint that process the final pipeline for the Panes, and all other node the tribe carry on its way to the schenegraph.

BACKEND OF NODE
```markdown
. 📂 NAN
├── 📄 ARCHTYPES.md
└── 📂 NANAC/
│  ├── 📄 NANAC-00000000000000000000000000.fbs
│  ├── 📄 NANAC-index.fbs
│  ├── 📄 NANAC_BrainJob-00000000000000000000000000.fbs
│  ├── 📄 NANAC_DecayRule-00000000000000000000000000.fbs
│  ├── 📄 NANAC_VectorDoll-00000000000000000000000000.fbs
├── 📄 NAN_Integarigation-00000000000000000000000000.fbs
├── 📄 NAN_index.fbs
├── 📄 NAU_Integarigation-00000000000000000000000000.fbs
└── 📄 NAU_index.fbs
```

*********************
*********************



TRIBE IS THE SIMPLIFIED CONTAINERS FOR A PIPELINE it is THE THICK CABLE THAT DRAGS ALONG... it is what unify 
the  Many pipeline..THE TRIBE CAN CONTAIN MANY PIPELINES for instance a dolby ATmos signal would contain 6 pipelines for audio and probably some data pipelines..
It ASsume the Animation of what ever edge is chosen for it... Colors will follow logic determined by tribe edge
This is the abstraction layer to simplify it when but can be opened up.

TRIBE

. 📂 tribe
└── 📂 agentic/
└── 📂 audiotory/
│  ├── 📄 Auditory_Index.fbs
│  ├── 📄 Auditory_Pipeline-00000000000000000000000000.fbs
└── 📂 informative/
└── 📂 narrative/
└── 📂 sensory/
└── 📂 spatial/
└── 📂 temporal/
├── 📄 tribe_Index.fbs
└── 📂 visual/
│  └── 📄 Visual_Index.fbs
```

PIPELINE
Specialized pipelines that can be woven in and out of tribes as you wanna manipulate them..
```markdown
. 📂 PZA
├── 📄 ARCHTYPES.md
└── 📂 PZAMP/
│  ├── 📄 PZAMP-00000000000000000000000000.fbs
│  ├── 📄 PZAMP-index.fbs
│  ├── 📄 PZAMP.qml
│  ├── 📄 PZAMP_BrainJob-00000000000000000000000000.fbs
│  ├── 📄 PZAMP_DecayRule-00000000000000000000000000.fbs
│  ├── 📄 PZAMP_VectorDoll-00000000000000000000000000.fbs
├── 📄 PZA_Integarigation-00000000000000000000000000.fbs
└── 📄 PZA_index.fbs
```


EDGE
The Visual behavior of the pipeline and the connection between Panes.

```markdown
. 📂 E
└── 📂 EBZ/
│  └── 📂 EBZAE/
│    ├── 📄 EBZAE.md
│  ├── 📄 TY
├── 📄 E_index.fbs
└── 📄 TYPES






*********************
*********************
Widgets this is the build block of most interfaces...


```markdown
. 📂 W
├── 📄 TYPES.md
└── 📂 WAC/
│  └── 📂 WACVC/
│    ├── 📄 WACVC-00000000000000000000000000.fbs
│    ├── 📄 WACVC-index.fbs
│    ├── 📄 WACVC.qml
│    ├── 📄 WACVC_BrainJob-00000000000000000000000000.fbs
│    ├── 📄 WACVC_DecayRule-00000000000000000000000000.fbs
│    ├── 📄 WACVC_VectorDoll-00000000000000000000000000.fbs
│  ├── 📄 WAC_Integarigation-00000000000000000000000000.fbs
│  ├── 📄 WAC_index.fbs
└── 📂 WAM/
└── 📂 WAV/
└── 📄 W_index.fbs
```

COMPONENT ALL WIDGES ARE CREATED OF COMPONENTS.. 
```markdown
. 📂 KTCBT
├── 📄 BUTTON.md
├── 📄 KTCBT-00000000000000000000000000.fbs
├── 📄 KTCBT-index.fbs
├── 📄 KTCBT.qml
├── 📄 KTCBT_BrainJob-00000000000000000000000000.fbs
├── 📄 KTCBT_DecayRule-00000000000000000000000000.fbs
└── 📄 KTCBT_VectorDoll-00000000000000000000000000.fbs
```