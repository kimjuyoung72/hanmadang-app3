package com.kh.app3.domain.api.svc;

import com.kh.app3.domain.PEvent;
import com.kh.app3.domain.PFacility;

import java.util.List;
import java.util.Set;

public interface ApiPubSVC {

  List<PEvent> apiCall(String fromDate, String toDate);

  List<PFacility> apiCall2(Set<String> facIds);
}
