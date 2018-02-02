function [Q,R] = QR_GivenRot(A)
  n = size(A,1);
  Q = eye(n);
  R = A;

  for j = 1:n
    for k = n:-1:(j+1)
      x = R(:,j);
      if norm([x(k-1), x(k)]) > 0
          c = x(k-1)/norm([x(k-1), x(k)]);
          s = -x(k)/norm([x(k-1), x(k)]);
          G = eye(n);
          G([k-1, k],[k-1, k]) = [c s; -s c];
          %Q = Q*G;
          Gtemp = G(k-1:k,k-1:k);
          Q(1:k-2,k-1:k) = Q(1:k-2,k-1:k)*Gtemp;
          Q(k-1:k,k-1:k) = Q(k-1:k, k-1:k)*Gtemp;
          Q(k+1:n,k-1:k) = Q(k+1:n,k-1:k)*Gtemp;
          
          %R = G'*R;
          Gtemp = Gtemp';
          R(k-1:k,1:k-2) = Gtemp*R(k-1:k,1:k-2);
          R(k-1:k,k-1:k) = Gtemp*R(k-1:k,k-1:k);
          R(k-1:k,k+1:n) = Gtemp*R(k-1:k,k+1:n);
      end
    end
  end
end