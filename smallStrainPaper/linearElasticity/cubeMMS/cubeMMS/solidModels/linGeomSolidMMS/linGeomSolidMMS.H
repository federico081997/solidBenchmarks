/*---------------------------------------------------------------------------*\
License
    This file is part of solids4foam.

    solids4foam is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    solids4foam is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with solids4foam.  If not, see <http://www.gnu.org/licenses/>.

Class
    linGeomSolidMMS

Description
    Mathematical model where linear geometry is assumed i.e. small strains and
    small rotations are assumed, where the increment of displacement is the
    primary unknown.

    The stress is calculated by the run-time selectable mechanical law.

Author
    Philip Cardiff, UCD.  All rights reserved.

SourceFiles
    linGeomSolidMMS.C

\*---------------------------------------------------------------------------*/

#ifndef linGeomSolidMMS_H
#define linGeomSolidMMS_H

#include "solidModel.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace solidModels
{

/*---------------------------------------------------------------------------*\
                        Class linGeomSolidMMS Declaration
\*---------------------------------------------------------------------------*/

class linGeomSolidMMS
:
    public solidModel
{
    // Private data

        //- Implicit stiffness; coefficient of the Laplacian term
        //  The value of this term only affects convergence and not the answer
        //  In the case of Hookean elasticity, (2*mu + lambda) is the optimum
        const volScalarField impK_;

        //- Implicit stiffness surface field
        surfaceScalarField impKf_;

        //- Reciprocal of impK
        //  We divide by impK every time tractionBoundarySnGrad is called so we
        //  will store the reciprocal for effficiency
        const volScalarField rImpK_;

        //- Store rho*ddt(D_old) for efficiency
        volVectorField rhoDdtD_0_;

    // Private Member Functions

        //- Disallow default bitwise copy construct
        linGeomSolidMMS(const linGeomSolidMMS&);

        //- Disallow default bitwise assignment
        void operator=(const linGeomSolidMMS&);

        //volVectorField calculateBodyForce();


protected:

    // Protected member functions

        //- Return nonlinear geometry enumerator
        virtual nonLinearGeometry::nonLinearType nonLinGeom() const
        {
            return nonLinearGeometry::LINEAR_GEOMETRY;
        }


public:

    //- Runtime type information
    TypeName("linearGeometryMMS");

    // Constructors

        //- Construct from components
        linGeomSolidMMS
        (
            Time& runTime,
            const word& region = dynamicFvMesh::defaultRegion
        );


    // Destructor

        virtual ~linGeomSolidMMS()
        {}


    // Member Functions

        // Access

            //- Each solidModel must indicate whether D or DD is the primary
            //  solution variable
            virtual volVectorField& solutionD()
            {
                // This model solves for DD
                return DD();
            }

            //- This solid model solves for DD instead of D
            virtual bool incremental() const
            {
                return true;
            }

        // Edit

            //- Evolve the solid solver and solve the mathematical model
            virtual bool evolve();

            //- Traction boundary surface normal gradient
            virtual tmp<vectorField> tractionBoundarySnGrad
            (
                const vectorField& traction,
                const scalarField& pressure,
                const fvPatch& patch
            ) const;
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace solidModel

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************************************************************* //
