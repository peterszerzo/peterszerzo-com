module Site.Styles.Raw exposing (..)


raw : String
raw =
    """
@keyframes fade-in {
  from {
    opacity: 0;
  }

  to {
    opacity: 1;
  }
}

@keyframes spin {
  0% {
    transform: rotate(0turn);
  }

  100% {
    transform: rotate(1turn);
  }
}
"""
