{
  environment.etc."polkit-1/rules.d/00-default-to-current-user.rules".text = # js
    ''
      polkit.addAdminRule(function(action, subject) {
        if( subject.isInGroup("wheel") ) {
          return ["unix-user:"+subject.user];
        }
        else {
          return [polkit.Result.NO];
        }
      });

    '';

}
