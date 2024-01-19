# MuscleMuseum

MuscleMuseum is a MATLAB package designed for Atomic, Molecular, and Optical (AMO) physics. It serves as an integrated solution for experimental control, data analysis, and numerical simulation. The package has several key features:

- **Object-Oriented Programming (OOP):** Unlike traditional script programming in MATLAB, MuscleMuseum is fully OOP-based. This choice is essential for handling the complexity of such projects.

- **Direct Hardware Control:** Leveraging MATLAB's rich set of hardware communication toolboxes, such as the [Data Acquisition Toolbox](https://www.mathworks.com/products/data-acquisition.html), MuscleMuseum provides seamless integration for automatic hardware control.

- **Data Management with PostgreSQL:** MuscleMuseum employs the robust [PostgreSQL](https://www.postgresql.org/) database system for efficient data management. This ensures reliable storage and retrieval of experimental data.

- **User-Friendly GUIs:** The package offers intuitive Graphical User Interfaces (GUIs) developed using [MATLAB App Designer](https://www.mathworks.com/products/matlab/app-designer.html).

Right now, I have implemented:

- A BEC experimental control and data analysis system (the BecExp class)
- Atomic data and atomic structure handling (the Atom class)
- A single-atom master equation simulation tool (the MeSim class)

Still under construction:

- Gross-Pitaevskii equation simulation
- Lattice simulation

Know issues

- The database functions I wrote are not compatible with MATLAB 2023b. Need to fix this in the future
