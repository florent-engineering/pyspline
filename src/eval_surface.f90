subroutine eval_surface(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Abstract eval_surface evaluates the n-dimensional b-spline surface
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate
  !     v       - Real, v coordinate
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated point, size ndim
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim
  double precision, intent(in)          :: u,v
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(ndim)

  ! Working
  integer                               :: idim
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  do idim=1,ndim
     val(idim) = b2val(u,v,0,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
  end do
  
end subroutine eval_surface

subroutine eval_surface_V(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,n,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Abstract eval_surface_V is a vector version of eval_surface
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate, length(n)
  !     v       - Real, v coordinate, length(n)
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated point, size n,ndim
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim,n
  double precision, intent(in)          :: u(n),v(n)
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(n,ndim)

  ! Working
  integer                               :: idim,i
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  do i=1,n
     do idim=1,ndim
        val(i,idim) = b2val(u(i),v(i),0,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
     end do
  end do
end subroutine eval_surface_V

subroutine eval_surface_M(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,n,m,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Abstract eval_surface_M is a matrix version of eval_surface
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate, size(n,m)
  !     v       - Real, v coordinate, size(n,m)
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated point, size (n,m,ndim)
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim,n,m
  double precision, intent(in)          :: u(n,m),v(n,m)
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(n,m,ndim)

  ! Working
  integer                               :: idim,i,j
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  do i=1,n
     do j=1,m
        do idim=1,ndim
           val(i,j,idim) = b2val(u(i,j),v(i,j),0,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
        end do
     end do
  end do
end subroutine eval_surface_M

subroutine eval_surface_deriv(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Abstract eval_surface_deriv evaluates the directional
  !     derivatives on surface (scalar version)
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate
  !     v       - Real, v coordinate
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated derivatives (du,dv), size (2,ndim)
    
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim
  double precision, intent(in)          :: u,v
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(2,ndim)

  ! Working
  integer                               :: idim
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  do idim=1,ndim
     val(1,idim) = b2val(u,v,1,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
     val(2,idim) = b2val(u,v,0,1,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
  end do
  
end subroutine eval_surface_deriv

subroutine eval_surface_deriv_V(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,n,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway Abstract eval_surface_deriv_V evaluates
  !     the directional derivatives on surface (Vector version)
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate, length(n)
  !     v       - Real, v coordinate, length(n)
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !     n       - Integer, Number of points to evaluate
  !
  !     Ouput 
  !     val     - Real, Evaluated points, size n,2,ndim
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim,n
  double precision, intent(in)          :: u(n),v(n)
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(n,2,ndim)

  ! Working
  integer                               :: idim,i
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  do i=1,n
     do idim=1,ndim
        val(i,1,idim) = b2val(u(i),v(i),1,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
        val(i,2,idim) = b2val(u(i),v(i),0,1,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
     end do
  end do
end subroutine eval_surface_deriv_V

subroutine eval_surface_deriv_M(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,n,m,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Written by Gaetan Kenway Abstract eval_surface_deriv_M evaluates
  !     the directional derivatives on surface (Matrix version)
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate, size(n,m)
  !     v       - Real, v coordinate, size(n,m)
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated point, size (n,m,2,2,ndim)
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim,n,m
  double precision, intent(in)          :: u(n,m),v(n,m)
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(n,m,2,2,ndim)

  ! Working
  integer                               :: idim,i,j
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  do i=1,n
     do j=1,m
        do idim=1,ndim
           val(i,j,1,1,idim) = b2val(u(i,j),v(i,j),2,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
           val(i,j,2,2,idim) = b2val(u(i,j),v(i,j),0,2,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
           val(i,j,1,2,idim) = b2val(u(i,j),v(i,j),1,1,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
           val(i,j,2,1,idim) = val(i,j,1,2,idim)
        end do
     end do
  end do
end subroutine eval_surface_deriv_M

subroutine eval_surface_deriv2(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Abstract eval_surface_deriv2 evaluates the 2nd directional
  !     derivatives on surface (scalar version)
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate
  !     v       - Real, v coordinate
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated derivatives (d2u2,dudv,d2v2), size (2,2,ndim)
    
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim
  double precision, intent(in)          :: u,v
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(2,2,ndim)

  ! Working
  integer                               :: idim
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val

  if (k>=3) then
     do idim=1,ndim
        val(1,1,idim) = b2val(u,v,2,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
        val(1,2,idim) = b2val(u,v,1,1,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
        val(2,1,idim) = val(1,2,idim)
        val(2,2,idim) = b2val(u,v,0,2,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
     end do
  else
     val(:,:,:) = 0.0
  end if
  
end subroutine eval_surface_deriv2

subroutine eval_surface_deriv2_V(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,n,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway Abstract eval_surface_deriv2_V evaluates
  !     the second directional derivatives on surface (Vector version)
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate, length(n)
  !     v       - Real, v coordinate, length(n)
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !     n       - Integer, Number of points to evaluate
  !
  !     Ouput 
  !     val     - Real, Evaluated points, size (n,2,2,ndim)
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim,n
  double precision, intent(in)          :: u(n),v(n)
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(n,2,2,ndim)

  ! Working
  integer                               :: idim,i
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val
  if (k>=3) then
     do i=1,n
        do idim=1,ndim
           val(i,1,1,idim) = b2val(u,v,2,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
           val(i,1,2,idim) = b2val(u,v,1,1,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
           val(i,2,1,idim) = val(i,1,2,idim)
           val(i,2,2,idim) = b2val(u,v,0,2,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
        end do
     end do
  else
     val(:,:,:,:) = 0.0
  end if
end subroutine eval_surface_deriv2_V

subroutine eval_surface_deriv2_M(u,v,tu,tv,ku,kv,coef,nctlu,nctlv,ndim,n,m,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Written by Gaetan Kenway Abstract eval_surface_deriv2_M evaluates
  !     the second directional derivatives on surface (Matrix version)
  !
  !     Description of Arguments
  !     Input
  !     u       - Real, u coordinate, size(n,m)
  !     v       - Real, v coordinate, size(n,m)
  !     tu      - Real,Knot vector in u. Length nctlu+ku
  !     tv      - Real,Knot vector in v. Length nctlv+kv
  !     ku      - Integer, order of B-spline in u
  !     kv      - Integer, order of B-spline in v
  !     coef    - Real,Array of B-spline coefficients  Size (nctlu,nctlv,ndim)
  !     nctlu   - Integer,Number of control points in u
  !     nctlv   - Integer,Number of control points in v
  !     ndim    - Integer, Spatial Dimension
  !
  !     Ouput 
  !     val     - Real, Evaluated point, size (n,m,2,2,ndim)
  
  
  ! Input
  integer         , intent(in)          :: ku,kv,nctlu,nctlv,ndim,n,m
  double precision, intent(in)          :: u(n,m),v(n,m)
  double precision, intent(in)          :: tu(nctlu+ku),tv(nctlv+kv)
  double precision, intent(in)          :: coef(nctlu,nctlv,ndim)

  ! Output
  double precision, intent(out)         :: val(n,m,2,2,ndim)

  ! Working
  integer                               :: idim,i,j
  double precision                      :: work(3*max(ku,kv) + kv)

  double precision b2val
  if (k>=3) then
     do i=1,n
        do j=1,m
           do idim=1,ndim
              val(i,j,1,1,idim) = b2val(u(i,j),v(i,j),2,0,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
              val(i,j,2,2,idim) = b2val(u(i,j),v(i,j),0,2,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
              val(i,j,1,2,idim) = b2val(u(i,j),v(i,j),1,1,tu,tv,nctlu,nctlv,ku,kv,coef(:,:,idim),work)
              val(i,j,2,1,idim) = val(i,j,1,2,idim)
           end do
        end do
     end do
  else
     val(:,:,:,:,:) = 0.0
  end if
end subroutine eval_surface_deriv2_M
